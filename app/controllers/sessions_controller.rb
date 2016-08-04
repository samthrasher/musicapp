class SessionsController < ApplicationController
  def new
  end

  def create
    email = login_params[:email]
    password = login_params[:password]

    @user = User.find_by_credentials(email, password)

    if @user
      login_user!(@user)
      redirect_to root_url
    else
      flash.now[:errors] = ["Invalid username or password." ]
      render :new
    end
  end

  def destroy
    logout!
    redirect_to root_url
  end

  private

  def login_params
    params.require(:user).permit(:email, :password)
  end

end
