class ApplicationController < ActionController::Base
  helper_method :current_user
  
  def current_user
    s = session[:session_token]
    
    user = User.find_by(session_token: s)
  end
  
  def login_user!(user)
      
    session[:session_token] = user.reset_session_token
    
  end
  
  def logout
    current_user.session_token = current_user.reset_session_token if current_user
    session[:session_token] = nil
  end
end
