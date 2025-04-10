class AttendeeDashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :validate_attendee!

  def index
    @events = current_user.events
  end

  def browse_events
    @events = RecommendedEventsService.new(current_user).call
  end

  def event_registrations
    @event_registrations = current_user.event_registrations
  end

  def past_events
    @past_events = current_user.events.where("end_time < ?", Time.current)
  end  

  private

  def validate_attendee!
    redirect_to root_path, alert: "You are not authorized to access this page." unless current_user.is_a?(AttendeeUser)
  end
end
