class ApplicationController < ActionController::Base
  helper_method :current_user
  
  def current_user
    s = session[:session_token]
    
    user = User.find_by(session_token: s)
  end
end
