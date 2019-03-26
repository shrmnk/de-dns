require 'rails_helper'

RSpec.describe Hostname, type: :model do
  it { is_expected.to belong_to(:zone).inverse_of(:hostnames) }

  # it { is_expected.to delegate(:cloudflare_account).to(:zone) }
  # it { is_expected.to delegate(:user).to(:cloudflare_account) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:a) }
  it { is_expected.to validate_uniqueness_of(:name).case_insensitive }

end
