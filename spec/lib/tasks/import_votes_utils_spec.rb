require 'rails_helper'
require File.join(Rails.root, 'lib', 'tasks', 'import_votes_utils.rb')

describe VoteLine do
  let(:valid_line) { %w(VOTE 1168127473 Campaign:ssss_uk_02B Validity:during Choice:Matthew) }
  subject(:vote_line) { VoteLine.new valid_line }

end
