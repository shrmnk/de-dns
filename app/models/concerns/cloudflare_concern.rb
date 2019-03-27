module CloudflareConcern
  extend ActiveSupport::Concern

  def cloudflare_credentials
    @cloudflare_credentials ||= {
      key: cloudflare_account.key,
      email: cloudflare_account.email
    }
  end

  def retrieve_dns_records(identifier, **opts)
    results = nil
    Cloudflare.connect(cloudflare_credentials) do |connection|
      # rubocop:disable Rails/DynamicFindBy
      cf_zone = connection.zones.find_by_id(identifier)
      # rubocop:enable Rails/DynamicFindBy
      results = if opts.present?
                  cf_zone.dns_records.each(opts).to_a.map(&:value)
                else
                  cf_zone.dns_records.map(&:value)
                end
    end
    results
  end

  def a_records
    records_by_type('A')
  end

  def aaaa_records
    records_by_type('AAAA')
  end

  def mx_records
    records_by_type('MX')
  end

  def records_by_type(type)
    return nil unless valid_type?(type)

    records.select { |r| r[:type] == type }
  end

  def valid_type?(type)
    %w[A AAAA MX].include?(type)
  end

end
