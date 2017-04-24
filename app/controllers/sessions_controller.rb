class SessionsController < ApplicationController
  def new
  end

  def create
    email = params[:session][:email].downcase
    password = params[:session][:password]
    if login(email, password)
      flash[:success] = 'Sccess to Login'
      redirect_to @user
    else
      flash.now[:danger] = "Failed to Login"
      render 'new'
    end
  end

  def destroy
    session[:user_id]=nil
    flash[:success] = 'Log out sccess'
    redirect_to root_path
  end
  
  
  
  private 
  
  def login(email,password)
    @user = User.find_by(email: email)
    if @user && @user.authenticate(password)
      #Login OK
      session[:user_id] = @user.id
      return true
    else
      #Login NOT OK
      return false
    end
  end
  
end
