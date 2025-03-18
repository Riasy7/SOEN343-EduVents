class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_event_manager!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
    @events = Event.all
  end

  def show
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
  
    if current_user.is_a?(OrganizerUser) || current_user.is_a?(ExecutiveUser)
      @event.organizer = current_user
    else
      redirect_to events_path, alert: "Only organizers and executives can create events." and return
    end
  
    if @event.save
      redirect_to @event, notice: "Event was successfully created."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @event.update(event_params)
      redirect_to @event, notice: "Event was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @event.destroy
    redirect_to events_path, notice: "Event was successfully deleted."
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:name, :event_type, :location)
  end

  def authorize_event_manager!
    unless current_user.is_a?(OrganizerUser) || current_user.is_a?(ExecutiveUser)
      redirect_to events_path, alert: "You are not authorized to perform this action."
    end
  end
end
