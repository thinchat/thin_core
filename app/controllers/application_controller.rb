class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user

  def current_user
    if cookies.signed[:user]
      params = JSON.parse(cookies.signed[:user])
      @current_user ||= Agent.find_or_create_by_thin_auth_id(params)
    end
  end
end
