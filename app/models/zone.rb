require 'cloudflare'

class Zone < ApplicationRecord
  belongs_to :cloudflare_account, inverse_of: :zones

  delegate :user, to: :cloudflare_account, allow_nil: false

  validates :identifier, presence: true
  validates :name, presence: true

  def dns_records
    @dns_records ||= retrieve_dns_records
  end

  def a_records
    records_by_type('A')
  end

  def cname_records
    records_by_type('CNAME')
  end

  def aaaa_records
    records_by_type('AAAA')
  end

  def mx_records
    records_by_type('MX')
  end

  private

  def cloudflare_credentials
    @cloudflare_credentials ||= {
      key: cloudflare_account.key,
      email: cloudflare_account.email
    }
  end

  def retrieve_dns_records
    records = nil
    Cloudflare.connect(cloudflare_credentials) do |connection|
      # rubocop:disable Rails/DynamicFindBy
      zone = connection.zones.find_by_id(identifier)
      # rubocop:enable Rails/DynamicFindBy
      records = zone.dns_records.map(&:value)
    end
    records
  end

  def records_by_type(type)
    return nil unless valid_type?(type)

    dns_records.select { |r| r[:type] == type }
  end

  def valid_type?(type)
    %w[A AAAA CNAME TXT MX].include?(type)
  end

end
