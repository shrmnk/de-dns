require 'cloudflare'

class CloudflareAccount < ApplicationRecord
  belongs_to :user, inverse_of: :cloudflare_accounts

  has_many :zones, inverse_of: :cloudflare_account, dependent: :destroy
  has_many :hostnames, through: :zones, dependent: :destroy

  validates :email, presence: true, format: Devise.email_regexp
  validates :key, presence: true

  def display_name
    name || email
  end

  def cloudflare_zones
    @cloudflare_zones ||= retrieve_cloudflare_zones
  end

  private

  def retrieve_cloudflare_zones
    results = nil
    Cloudflare.connect(key: key, email: email) do |connection|
      results = connection.zones.map(&:value)
    end
    # Convert to name => id
    results.map { |z| [z[:name], z[:id]] }.to_h
  end

end
