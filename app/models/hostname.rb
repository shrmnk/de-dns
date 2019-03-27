require 'cloudflare'
require 'securerandom'

class Hostname < ApplicationRecord
  include CloudflareConcern

  after_validation :generate_token
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

  def generate_token
    self.token = SecureRandom.hex if token.blank?
  end

  # rubocop:disable Metrics/MethodLength,Metrics/AbcSize
  def update_cloudflare
    return unless changed?
    return if errors.any?

    Cloudflare.connect(cloudflare_credentials) do |connection|
      # rubocop:disable Rails/DynamicFindBy
      dns_records = connection.zones.find_by_id(zone.identifier).dns_records
      # rubocop:enable Rails/DynamicFindBy

      changes.each do |type, values|
        type = type.upcase
        next unless valid_type?(type)

        _old_value, new_value = *values
        new_value.chomp!

        current_records = dns_records.each(name: name, type: type).to_a
        begin
          if current_records.any?
            logger.info "Updating #{type} record for #{name} (#{current_records.first})"
            current_records.first.update_content(new_value)
          else
            logger.info "No existing #{type} records for #{name}"
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

end
