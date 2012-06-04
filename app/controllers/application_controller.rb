class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user

  def current_user
    @current_user ||= Hashie::Mash.new(JSON.parse(cookies.signed[:user])) if cookies.signed[:user]
  end
end
