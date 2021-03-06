class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  def current_user
    @current_user ||= User.find_by(device_token: request.headers["HTTP_TB_DEVICE_TOKEN"])
  end
  helper_method :current_user
end
