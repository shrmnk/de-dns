class Zone < ApplicationRecord

  belongs_to :cloudflare_account, inverse_of: :zones
  
  delegate :user, to: :cloudflare_account, allow_nil: false

  validates :identifier, presence: true
  validates :name, presence: true

end
