class MessagesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_event
    before_action :validate_permissions, only: [ :index, :create ]

    def index
      @messages = Message.where(event: @event).order(:created_at)
    end

    def create
        @message = Message.new(message_params)
        @message.sender = current_user
        @message.event = @event

        if current_user.is_a?(AttendeeUser)
          @message.receiver = @event.organizer
        elsif current_user.is_a?(OrganizerUser)
          @message.receiver = User.find(params[:message][:receiver_id])
        end

        if @message.save
          NotificationService.call(current_user, :new_event_message, @message)
          redirect_to event_messages_path(@event), notice: "Message sent successfully."
        else
          redirect_to event_messages_path(@event), alert: "Failed to send message."
        end
    end

    private

    def set_event
      @event = Event.find(params[:event_id])
    end

    def message_params
        params.require(:message).permit(:content, :receiver_id)
    end

    def validate_permissions
      if current_user.is_a?(AttendeeUser)
        unless current_user.registered_for_event?(@event.id)
          redirect_to events_path, alert: "You are not authorized to view or send messages for this event."
        end
      elsif current_user.is_a?(OrganizerUser)
        unless @event.organizer == current_user
          redirect_to organizer_dashboard_path, alert: "You are not authorized to view or send messages for this event."
        end
      else
        redirect_to root_path, alert: "You are not authorized to access this page."
      end
    end
end
