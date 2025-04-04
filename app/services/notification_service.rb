class NotificationService
	def self.call(user, notification_type, *args)
		new(user, notification_type, *args).send_notification
	end

	def initialize(user, notification_type, *args)
		@user = user
		@notification_type = notification_type
		@args = args
	end

	def send_notification
		return unless @user.notification_preference
		return unless email_method_defined? && sms_method_defined?

		send_email if @user.notification_preference.email_enabled
		send_sms if @user.notification_preference.sms_enabled
	end

	private

	def send_email
		NotificationMailer.public_send(@notification_type, @user, *@args).deliver_later
	end

	def send_sms
		# TODO
	end

	def email_method_defined?
		NotificationMailer.respond_to?(@notification_type)
	end

	def sms_method_defined?
		true
	end
end