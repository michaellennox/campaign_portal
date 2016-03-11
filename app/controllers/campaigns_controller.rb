class CampaignsController < ApplicationController
  def index
    @campaigns = Campaign.all
  end

  def show
  end
end
