class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :disclaimer
  
  helper_method :current_user

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def disclaimer
    @disclaimer = true unless request.user_agent =~ /Chrome|Safari/
  end
end
