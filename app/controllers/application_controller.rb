class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
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

  def configure_permitted_parameters
    added_attrs = [:username, :email, :password, :password_confirmation, :first_name, :last_name, :type, :attendee_type]
    devise_parameter_sanitizer.permit(:sign_up, keys: added_attrs)
    devise_parameter_sanitizer.permit(:account_update, keys: added_attrs)
  end
end
