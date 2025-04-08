require "ostruct"

class VenuesController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!, only: [ :index ]
  before_action :authorize_executive!, only: [ :new, :create, :edit, :update, :destroy ]
  before_action :set_venue, only: [ :add_schedule, :edit_schedule, :reset_schedule, :show, :edit, :update, :destroy ]
  before_action :authorize_venue_manager!, only: [ :edit, :update, :destroy ]

  # GET /venues
  def index
    @venues = Venue.all
  end

  # GET /venues/1
  def show
  end

  # GET /venues/new
  def new
    @venue = Venue.new()
    @venue.build_location
  end

  # GET /venues/1/edit
  def edit
    @venue.build_location unless @venue.location
  end

  # POST /venues
  def create
    @venue = Venue.new(venue_params)
    @venue.organization = current_user.organization
    if @venue.save
      redirect_to @venue, notice: "Venue was successfully created."
    else
      render :new
    end
  end

  # PATCH/PUT /venues/1
  def update
    if @venue.update(venue_params)
      redirect_to @venue, notice: "Venue was successfully updated."
    else
      render :edit
    end
  end

  # DELETE /venues/1
  def destroy
    @venue.destroy
    redirect_to venues_url, notice: "Venue was successfully destroyed."
  end

  def edit_schedule
    @events = (@venue.schedule || []).map do |s|
      OpenStruct.new(
        start_time: DateTime.parse(s["start_time"]),
        end_time: DateTime.parse(s["end_time"]),
        title: "Available"
      )
    end
  end

  def add_schedule
    new_schedule = {
      "start_time" => DateTime.parse(params[:schedule_start_time]),
      "end_time"   => DateTime.parse(params[:schedule_end_time])
    }

    schedules = @venue.schedule || []
    schedules << new_schedule

    if @venue.update(schedule: schedules)
      @events = schedules.map do |s|
        OpenStruct.new(
          start_time: s["start_time"],
          end_time: s["end_time"],
          title: "Available"
      )
      end

      respond_to do |format|
        format.js   # renders add_schedule.js.erb
        format.html { redirect_to @venue, notice: "Schedule updated." }
      end
    else
      respond_to do |format|
        format.js { render js: "alert('Error updating schedule');" }
        format.html { redirect_to @venue, alert: "Error updating schedule." }
      end
    end
  end

  def reset_schedule
    @venue.schedule = nil
    if @venue.save!
      redirect_to @venue, warning: "Schedule was reset."
    else
      redirect_to edit_schedule_venues_path, alert: "Error resetting schedule."
    end
  end

  private

  # this is to make sure only the user reponsible for a venue can modify the venue
  def authorize_venue_manager!
    unless @venue.organization == current_user.organization
      redirect_to root_path, alert: "You are not authorized to perform this action."
    end
  end

  def authorize_admin!
    redirect_to root_path, alert: "Access denied. Admins only." unless current_user.is_a?(AdminUser)
  end

  def authorize_executive!
    redirect_to root_path, alert: "Access denied. Admins only." unless current_user.is_a?(ExecutiveUser)
  end

  def set_venue
    @venue = Venue.find(params[:id])
  end

  def venue_params
    params.require(:venue).permit(
      :name, :max_capacity, :schedule,
      location_attributes: [ :id, :name, :address1, :address2, :city, :state, :country, :postal_code ]
    )
  end
end
