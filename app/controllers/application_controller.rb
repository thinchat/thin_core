class ApplicationController < ActionController::Base
  helper_method :current_user
  before_filter :set_access
  before_filter :set_location

  def set_access
    response.headers["Access-Control-Allow-Origin"] = "*"
  end

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

  def require_login
    redirect_to not_found_path and return unless get_agent
  end


  private

  def set_location
    @location = "NOLOCSET"
  end
end
