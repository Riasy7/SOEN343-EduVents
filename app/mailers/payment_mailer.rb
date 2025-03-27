class PaymentMailer < ApplicationMailer
end
class PaymentMailer < ApplicationMailer
    def payment_success(payment)
      @payment = payment
      @user = payment.user
      @event = payment.event
  
      mail(to: @user.email, subject: "Payment Confirmation for #{@event.name}")
    end
  end