class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :cloudflare_accounts, inverse_of: :user, dependent: :destroy
  has_many :zones, through: :cloudflare_accounts, dependent: :destroy
  has_many :hostnames, through: :zones, dependent: :destroy

end
