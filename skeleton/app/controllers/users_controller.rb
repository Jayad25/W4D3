class UsersController < ApplicationController

  def new
    
    render :new
  end
    
  
  def create
  user = User.new(user_params)
  
  user.save!
  
  redirect_to cats_url
  
  end
  
  private
  def user_params
    params.require(:user).permit(:username,:password)
  end
end