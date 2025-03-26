class PaymentsController < ApplicationController
    before_action :authenticate_user!
  
    def index
      @payments = current_user.payments.includes(:event)
    end
  end