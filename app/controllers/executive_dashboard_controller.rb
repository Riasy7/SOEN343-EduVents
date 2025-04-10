class ExecutiveDashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :validate_executive!

  def index
    @events = Event.all

    @revenue_data = @events.each_with_object({}) do |event, data|
      revenue = event.payments.successful.sum(:amount)
      data[event.name] = revenue
    end

    @ratings_data = @events.each_with_object({}) do |event, data|
      average_rating = event.average_rating
      data[event.name] = average_rating
    end
  end

  def venues
    @venues = current_user.organization.venues
  end

  private

  def validate_executive!
    redirect_to root_path, alert: "You are not authorized to access this page." unless current_user.is_a?(ExecutiveUser)
  end
end