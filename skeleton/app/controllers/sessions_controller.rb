class SessionsController < ApplicationController
  
  
  def new
    render :new
  end
  
  def create
    
    user = User.find_by_credentials(params[:user][:username],params[:user][:password])
    
    if user
      
      session[:session_token] = user.reset_session_token
      # user.save!
      redirect_to cats_url
    else
      render :new
    end
  end
  
  def destroy
    
    current_user.session_token = current_user.reset_session_token if current_user
    session[:session_token] = nil
  end
end