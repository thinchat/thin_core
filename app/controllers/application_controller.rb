class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user

  def current_user
    @current_user ||= (get_agent || get_or_create_guest)
  end

  def get_or_create_guest
    guest = Guest.find_or_create_by_cookie(cookies.signed[:guest])
    unless cookies.signed[:guest]
      cookies.permanent.signed[:guest] = { id: guest.id }.to_json
    end
    guest
  end

  def get_agent
    if cookies.signed[:user]
      Agent.new_from_cookie(cookies.signed[:user])
    end
  end
end
