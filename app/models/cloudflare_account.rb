class CloudflareAccount < ApplicationRecord
  belongs_to :user, inverse_of: :cloudflare_accounts

  has_many :zones, inverse_of: :cloudflare_account, dependent: :destroy
  has_many :hostnames, through: :zones, dependent: :destroy

  validates :email, presence: true, format: Devise.email_regexp
  validates :key, presence: true

  def display_name
    name || email
  end

end
