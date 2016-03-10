class Choice < ActiveRecord::Base
  belongs_to :campaign
  has_many :votes
end
