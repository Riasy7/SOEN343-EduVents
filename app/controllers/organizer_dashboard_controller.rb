class OrganizerDashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_dashboard_access

  def index
    @events = if current_user.is_a?(AdminUser)
                Event.all
              else
                Event.where(organizer_id: current_user.id)
              end
  end

  private

  def authorize_dashboard_access
    unless current_user.is_a?(OrganizerUser) || current_user.is_a?(AdminUser)
      redirect_to root_path, alert: "You are not authorized to access this page."
    end
  end
end
