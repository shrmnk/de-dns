require 'rails_helper'

RSpec.describe CloudflareAccount, type: :model do

  it { is_expected.to belong_to(:user).inverse_of(:cloudflare_accounts) }
  it { is_expected.to have_many(:zones).inverse_of(:cloudflare_account).dependent(:destroy) }
  
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:key) }

end
