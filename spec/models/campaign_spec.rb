require 'rails_helper'

RSpec.describe Campaign, type: :model do
  it { is_expected.to have_many :choices }

  describe '#invalid_votes' do
    it 'counts the number of invalid votes for the campaign' do
      campaign = Campaign.create
      choice = campaign.choices.create
      choice.votes.create(is_valid: false)

      expect(campaign.invalid_votes).to eq 1
    end
  end
end
