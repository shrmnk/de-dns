require 'cloudflare'

class Hostname < ApplicationRecord
  include CloudflareConcern

  before_save :update_cloudflare

  belongs_to :zone, inverse_of: :hostnames

  delegate :cloudflare_account, to: :zone, allow_nil: false
  delegate :user, to: :cloudflare_account, allow_nil: false

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :a, presence: true

  validate :name_must_end_with_zone

  def records
    @records ||= retrieve_dns_records(zone.identifier, name: name)
  end

  def name_must_end_with_zone
    return if name.nil?
    return if name.ends_with?(zone.name)

    errors.add(:name, "must end with the zone (#{zone.name})")
  end

  private

  # rubocop:disable Metrics/MethodLength,Metrics/AbcSize
  def update_cloudflare
    return unless changed?

    Cloudflare.connect(cloudflare_credentials) do |connection|
      # rubocop:disable Rails/DynamicFindBy
      dns_records = connection.zones.find_by_id(zone.identifier).dns_records
      # rubocop:enable Rails/DynamicFindBy

      changes.each do |type, values|
        next unless valid_types.include?(type)

        _old_value, new_value = *values
        type = type.upcase
        # Make sure there are no trailing spaces
        new_value.chomp!

        records = dns_records.each(name: name, type: type).to_a
        begin
          if records.any?
            logger.info "Updating #{type} record for #{name} (#{records.first})"
            records.first.update_content(new_value)
          else
            logger.info "No #{type} records for #{name}"
            dns_records.create(type, name, new_value, proxied: false)
          end
        rescue Cloudflare::RequestError => e
          error_message = e.message[e.message.index('>') + 3..-1]
          errors.add(type.to_sym, "Record API Error: #{error_message}")
        end
      end
    end

    # Rollback update if there were any API errors
    raise ActiveRecord::Rollback, 'API Errors' if errors.any?
  end
  # rubocop:enable Metrics/MethodLength,Metrics/AbcSize

  def valid_types
    @valid_types ||= %w[a aaaa mx]
  end

end
