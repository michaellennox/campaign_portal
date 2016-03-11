require 'rails_helper'

RSpec.describe Choice, type: :model do
  it { is_expected.to belong_to :campaign }
  it { is_expected.to have_many :votes }

  describe '#counted_votes' do
    it 'summarises the number of valid votes' do
      choice = Choice.create
      3.times { choice.votes.create(is_valid: true) }
      choice.votes.create(is_valid: false)

      expect(choice.counted_votes).to eq(3)
    end
  end
end
