class NotificationMailer < ApplicationMailer
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
end
  