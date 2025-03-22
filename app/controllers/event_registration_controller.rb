class EventRegistrationController < ApplicationController
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

    unless @user.is_a?(AttendeeUser)
      redirect_to events_path, alert: "Only attendees can register for events." and return
    end

    # if user is already registered for this event, return
    if @user.event_registrations.where(event_id: @event.id).count > 0
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
end
