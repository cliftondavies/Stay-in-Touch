# rubocop:disable Layout/LineLength
require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'Associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:post) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:content) }
    it { is_expected.to validate_length_of(:content).is_at_most(200).with_long_message('200 characters in comment is the maximum allowed.') }
  end
end

# rubocop:enable Layout/LineLength
