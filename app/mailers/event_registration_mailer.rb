class EventRegistrationMailer < ApplicationMailer
    def registration_confirmation(event_registration)
      @event_registration = event_registration
      @event = @event_registration.event
      @attendee = @event_registration.attendee
  
      mail(
        to: @attendee.email,
        subject: "Registration Confirmation for #{@event.name}"
      )
    end
  end
  