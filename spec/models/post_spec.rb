# rubocop:disable Layout/LineLength
require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'Associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:comments).dependent(:destroy) }
    it { is_expected.to have_many(:likes).dependent(:destroy) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:content) }
    it { is_expected.to validate_length_of(:content).is_at_most(1000).with_long_message('1000 characters in post is the maximum allowed.') }
  end
end

# rubocop:enable Layout/LineLength
