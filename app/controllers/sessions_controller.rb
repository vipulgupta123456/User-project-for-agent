class SessionsController < ApplicationController
  before_filter :authenticate_user, :only => [:home, :profile, :setting]
before_filter :save_login_state, :only => [:login, :login_attempt]
  def login

  end
  def login_attempt
    authorized_user = User.authenticate(params[:username_or_email],params[:login_password])
    if authorized_user
      flash[:notice] = "Wow Welcome again, you logged in as #{authorized_user.username}"
      render "home"
       UserMailer.welcome_email(authorized_user).deliver
    else
      flash[:notice] = "Invalid Username or Password"
      flash[:color]= "invalid"
      render "login"	
    end
  end
  def home

  end

  def profile
  	  @current_user = User.find session[:user_id] 

  end
  def show
  end
  def setting
  end
  def logout
  session[:user_id] = nil
  redirect_to :action => 'login'
end
end