class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

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

  def dashboard_path_for(resource)
    case resource
    when AttendeeUser
      attendee_dashboard_path
    when ExecutiveUser
      executive_dashboard_path
    when OrganizerUser
      organizer_dashboard_path
    when AdminUser
      organizer_dashboard_path # for now bring to organizer dashboard
    else
      root_path
    end
  end

  def configure_permitted_parameters
    added_attrs = [ :username, :email, :password, :password_confirmation, :first_name, :last_name, :type, :attendee_type ]
    devise_parameter_sanitizer.permit(:sign_up, keys: added_attrs)
    devise_parameter_sanitizer.permit(:account_update, keys: added_attrs)
  end
end
