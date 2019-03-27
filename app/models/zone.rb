require 'cloudflare'

class Zone < ApplicationRecord
  include CloudflareConcern

  belongs_to :cloudflare_account, inverse_of: :zones

  has_many :hostnames, inverse_of: :zone, dependent: :destroy

  delegate :user, to: :cloudflare_account, allow_nil: false

  validates :identifier, presence: true, uniqueness: { case_sensitive: false }
  validates :name, presence: true, uniqueness: { case_sensitive: false }

  def records
    @records ||= retrieve_dns_records(identifier)
  end

end
