class EventRegistrationController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event_registration, only: [:destroy, :show]
  before_action :authorize_attendee!, only: [:destroy, :register]
  before_action :check_owner!, only: [:destroy, :show]

  def destroy
    @event_registration = EventRegistration.find(params[:id])

    if @event_registration.destroy
      redirect_to events_path, notice: "Event registration was successfully canceled."
    else
      redirect_to events_path, alert: "Error: Unable to cancel event registration."
    end
  end

  def register
    @event = Event.find(params[:id])
    @user = current_user

    if @user.registered_for_event?(@event.id)
      redirect_to events_path, alert: "You are already registered for this event." and return
    end

    @event_registration = EventRegistration.new(attendee_id: @user.id, event_id: @event.id)

    if @event_registration.save
      redirect_to @event_registration, notice: "You successfully registered for #{@event.name}."
    else
      redirect_to @event, alert: "Registration failed: #{@event_registration.errors.full_messages.to_sentence}"
    end
  end

  def show
    @event_registration = EventRegistration.find(params[:id])
    @event = @event_registration.event
    @user = @event_registration.attendee
  end

  private

  def event_registration_params
    params.require(:event_registration).permit(:event_id, :attendee_id)
  end

  def authorize_attendee!
    unless current_user.is_a?(AttendeeUser)
      redirect_to events_path, alert: "Only attendees can perform this action." and return
    end
  end

  def check_owner!
    unless @event_registration.attendee_id == current_user.id
      redirect_to events_path, notice: "Only the owner of this event registration can perform this action."
    end
  end

  def set_event_registration
    @event_registration = EventRegistration.find_by(id: params[:id])
    unless @event_registration
      redirect_to events_path, alert: "Event registration not found."
    end
  end
end
