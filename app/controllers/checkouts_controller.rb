class CheckoutsController < ApplicationController
  before_action :authenticate_user!

  def create
    event = Event.find(params[:event_id])

    unless current_user.is_a?(AttendeeUser)
      flash[:alert] = "Only attendees can register for events."
      redirect_to event_path(event) and return
    end

    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      customer_email: current_user.email,
      line_items: [{
        price_data: {
          currency: 'usd',
          product_data: {
            name: event.name,
          },
          unit_amount: event.price_cents,
        },
        quantity: 1,
      }],
      mode: 'payment',
      success_url: success_checkouts_url + "?session_id={CHECKOUT_SESSION_ID}",
      cancel_url: cancel_checkouts_url
    )

    redirect_to session.url, allow_other_host: true
  end

  def success
    session = Stripe::Checkout::Session.retrieve(params[:session_id])
    payment_intent = Stripe::PaymentIntent.retrieve(session.payment_intent)
    line_items = Stripe::Checkout::Session.list_line_items(session.id)

    event_name = line_items.data[0].description
    event = Event.find_by(name: event_name)

    unless event
      flash[:alert] = "Event not found."
      redirect_to root_path and return
    end

    payment = Payment.create!(
      user: current_user,
      event: event,
      amount: payment_intent.amount / 100.0,
      currency: payment_intent.currency,
      status: 'paid',
      stripe_payment_intent_id: payment_intent.id
    )

    PaymentMailer.payment_success(payment).deliver_now

    flash[:notice] = "Payment successful! You are now registered for the event."
    redirect_to event_path(event)
  end
end