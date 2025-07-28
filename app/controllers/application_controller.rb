class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :authenticate_user!
  before_action :current_user_password

  def current_user_password
    return nil unless user_signed_in?
    @current_user_password ||= current_user.user_passwords.find_by(password: @password)
  end

  helper_method :current_user_password
end
