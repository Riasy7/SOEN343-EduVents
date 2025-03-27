class EventRegistrationController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event_registration, only: [:destroy, :show]

  # callbacks used so that speakers can attend as both listeners, or speakers
  # and so that listeners can only attend as listeners
  before_action :authorize_attendee!, only: [:register_as_listener]
  before_action :authorize_speaker_attendee!, only: [:register_as_speaker]

  before_action :check_owner!, only: [:destroy, :show]

  def destroy
    @event_registration = EventRegistration.find(params[:id])

    if @event_registration.destroy
      redirect_to attendee_dashboard_events_path, notice: "Event registration was successfully canceled."
    else
      redirect_to attendee_dashboard_events_path, alert: "Error: Unable to cancel event registration."
    end
  end

  def register(attendee_id, event_id, role)
    attendee = AttendeeUser.find(attendee_id)
    event = Event.find(event_id)

    if attendee.registered_for_event?(event_id)
      redirect_to attendee_dashboard_events_path, alert: "You are already registered for this event." and return
    end

    # create new event registration immediatly if the event is free
    if event.price_cents.nil? || event.price_cents == 0
      @event_registration = EventRegistration.create(attendee_id:, event_id:, role:)
      EventRegistrationMailer.registration_confirmation(@event_registration).deliver_later
      redirect_to @event_registration, notice: "You successfully registered for #{event.name}." and return
    end

    # paid event so we redirect to stripe checkout
    render "checkouts/redirect", locals: { event_id: event.id, attendee_id: attendee.id, role: role }
  end

  def register_as_listener
    register(current_user.id, params[:id], "listener")
  end

  def register_as_speaker
    register(current_user.id, params[:id], "speaker")
  end

  def show
    @event_registration = EventRegistration.find(params[:id])
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

  def authorize_speaker_attendee!
    unless current_user.is_a?(AttendeeUser) && current_user.attendee_type == "speaker"
      redirect_to events_path, alert: "Only speaker attendees can perform this action." and return
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