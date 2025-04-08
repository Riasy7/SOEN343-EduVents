class NotificationMailer < ApplicationMailer
  layout "notification_mailer"

  def event_registration_confirmation(attendee, event_registration)
    @attendee = attendee
    @event_registration = event_registration
    @event = event_registration.event

      mail(
          to: @attendee.email,
          subject: "Registration Confirmation for #{@event.name}"
      )
  end

  def event_reminder(user, event)
    @user = user
    @event = event
    mail(to: @user.email, subject: "Reminder: #{@event.title}")
  end

  def new_event_message(user, message)
    @message = message
    @title = "New Message for #{@message.event.name}"
    mail(to: user.email, subject: "New Message Notification")
  end
end
