class VoteLine
  def initialize(vote_line)
    @vote_line = vote_line
  end

  def valid?
    return false unless valid_vote_key? && valid_campaign? && valid_validity? && valid_choice?
    true
  end

  def save
    campaign = Campaign.where(ref: campaign_ref).first_or_create
    choice = campaign.choices.where(name: choice_name).first_or_create
    choice.votes.create(is_valid: valid_vote?, time_cast: time_cast)
  end

  private

  attr_reader :vote_line

  def valid_vote_key?
    vote_key == 'VOTE'
  end

  def valid_campaign?
    campaign_key == 'Campaign:'
  end

  def valid_validity?
    validity_key == 'Validity:'
  end

  def valid_choice?
    choice_key == 'Choice:' && choice_name != ''
  end

  def valid_vote?
    vote_line[3][9..-1] == 'during'
  end

  def vote_key
    vote_line[0]
  end

  def campaign_key
    vote_line[2][0, 9]
  end

  def campaign_ref
    vote_line[2][9..-1]
  end

  def choice_key
    vote_line[4][0, 7]
  end

  def choice_name
    vote_line[4][7..-1]
  end

  def validity_key
    vote_line[3][0, 9]
  end

  def time_cast
    Time.at(vote_line[1].to_i)
  end
end
