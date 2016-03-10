class VoteLine
  def initialize(vote_line)
    @vote_line = vote_line
  end

  def valid?
    return false unless valid_vote_key? && valid_campaign? && valid_validity? && valid_choice?
    true
  end

  def save
    campaign = Campaign.where(ref: vote_line[2][9..-1]).first_or_create
    choice = campaign.choices.where(name: vote_line[4][7..-1]).first_or_create
    choice.votes.create(is_valid: valid_vote?, time_cast: Time.at(vote_line[1].to_i))
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

  def valid_vote?
    vote_line[3][9..-1] == 'during'
  end
end
