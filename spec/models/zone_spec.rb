require 'rails_helper'

RSpec.describe Zone, type: :model do
  it { is_expected.to belong_to(:cloudflare_account).inverse_of(:zones) }
  it { is_expected.to have_many(:hostnames).inverse_of(:zone).dependent(:destroy) }

  # it { is_expected.to delegate(:user).to(:cloudflare_account) }

  it { is_expected.to validate_presence_of(:identifier) }
  it { is_expected.to validate_presence_of(:name) }
end
