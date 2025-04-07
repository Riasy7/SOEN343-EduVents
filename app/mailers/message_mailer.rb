class MessageMailer < ApplicationMailer
    def new_message_notification(message)
      @message = message
      mail(to: @message.receiver.email, subject: "New Message from #{@message.sender.get_full_name}")
    end
end