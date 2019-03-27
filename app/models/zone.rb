require 'cloudflare'

class Zone < ApplicationRecord
  include CloudflareConcern

  belongs_to :cloudflare_account, inverse_of: :zones

  has_many :hostnames, inverse_of: :zone, dependent: :destroy

  delegate :user, to: :cloudflare_account, allow_nil: false

  validates :identifier, presence: true
  validates :name, presence: true

  def records
    @records ||= retrieve_dns_records(identifier)
  end

end
