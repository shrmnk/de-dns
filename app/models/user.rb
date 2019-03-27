class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::Whitelist

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  has_many :cloudflare_accounts, inverse_of: :user, dependent: :destroy
  has_many :zones, through: :cloudflare_accounts, dependent: :destroy
  has_many :hostnames, through: :zones, dependent: :destroy

  validates :email,
            presence: true,
            format: Devise.email_regexp,
            uniqueness: { case_sensitive: false }

end
