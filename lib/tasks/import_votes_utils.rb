class VoteLine
  def initialize(vote_line)
    @vote_line = vote_line
  end

  def valid?
    return false if vote_line[0] != 'VOTE'
    true
  end

  private

  attr_reader :vote_line
end
