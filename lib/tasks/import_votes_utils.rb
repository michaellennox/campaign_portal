class VoteLine
  def initialize(vote_line)
    @vote_line = vote_line
  end

  def valid?
    return false unless valid_vote_key? && valid_campaign? && valid_validity? && valid_choice?
    true
  end

  private

  attr_reader :vote_line

  def valid_vote_key?
    vote_line[0] == 'VOTE'
  end

  def valid_campaign?
    vote_line[2][0, 9] == 'Campaign:'
  end

  def valid_validity?
    vote_line[3][0, 9] == 'Validity:'
  end

  def valid_choice?
    vote_line[4][0, 7] == 'Choice:' && vote_line[4].length > 7
  end
end
