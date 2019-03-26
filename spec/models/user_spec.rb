require 'rails_helper'

RSpec.describe User, type: :model do

  it { is_expected.to have_many(:cloudflare_accounts).inverse_of(:user).dependent(:destroy) }
  it { is_expected.to have_many(:zones).through(:cloudflare_accounts).dependent(:destroy) }

  it { is_expected.to validate_presence_of(:email) }

end
