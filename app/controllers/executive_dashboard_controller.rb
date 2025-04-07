class ExecutiveDashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :validate_executive!

  def index
  end

  def venues
    @venues = current_user.organization.venues
  end

  private

  def validate_executive!
    redirect_to root_path, alert: "You are not authorized to access this page." unless current_user.is_a?(ExecutiveUser)
  end
end
