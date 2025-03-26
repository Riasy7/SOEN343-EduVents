class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  protect_from_forgery with: :exception

  before_action :sign_out_on_public_pages

  def after_sign_in_path_for(_resource)
    dashboard_path_for(_resource)
  end

  def after_sign_up_path_for(_resource)
    dashboard_path_for(_resource)
  end

  def after_sign_out_path_for(_resource_or_scope)
    root_path
  end

  private

  def dashboard_path_for(_resource)
    if _resource.is_a?(AttendeeUser)
      attendee_dashboard_path
    elsif _resource.is_a?(OrganizerUser)
      organizer_dashboard_path
    end
  end

  def sign_out_on_public_pages
    public_pages = [ about_path, root_path ]

    return unless user_signed_in? && public_pages.include?(request.path)

    sign_out(current_user)
    redirect_to root_path, alert: "You have been signed out."
  end
end
