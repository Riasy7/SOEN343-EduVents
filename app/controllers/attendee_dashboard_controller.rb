class AttendeeDashboardController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def events
    @events = RecommendedEventsService.new(current_user).call
  end
end
