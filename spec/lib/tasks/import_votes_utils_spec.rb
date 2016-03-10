require 'rails_helper'
require File.join(Rails.root, 'lib', 'tasks', 'import_votes_utils.rb')

describe VoteLine do
  let(:valid_line) { %w(VOTE 1168127473 Campaign:ssss_uk_02B Validity:during Choice:Matthew) }
  subject(:vote_line) { VoteLine.new valid_line }

  describe '#valid?' do
    it 'returns true when the vote line is valid' do
      expect(vote_line.valid?).to be true
    end

    it 'returns false when given an invalid VOTE prefix' do
      invalid_vote_prefix = %w(VACK 1168127473 Campaign:ssss_uk_02B Validity:during Choice:Matthew)
      invalid_vote_line = VoteLine.new invalid_vote_prefix
      expect(invalid_vote_line.valid?).to be false
    end
  end
end
