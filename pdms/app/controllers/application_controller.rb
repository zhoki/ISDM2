class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :update_sanitized_params, if: :devise_controller?
  def update_sanitized_params
    devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:firstName, :lastName, :email, :password)}
    devise_parameter_sanitizer.for(:account_update) {|u| u.permit(:firstName, :lastName, :email, :password, :password_confirmation, :current_password)}
  end

  def admin_user
    if current_user.role_id != 1
      flash[:error] = "You don't have permission to access this page"
      redirect_to root_path
    end
  end

end
