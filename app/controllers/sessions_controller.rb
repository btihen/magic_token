class SessionsController < ApplicationController
  skip_before_action :users_only, only: :create

  def create
    token = params[:token].to_s
    # find the user with a matching token and with current-time < token_expired_at
    user = User.where(token: token)
               .where('users.token_expires_at > (?)', DateTime.now)
               .first
    if user
      # create the session id for current_user to access
      session[:user_id] = user.id
      # send the user to their homepage (or where erver you prefer)
      redirect_to(home_path, notice: "Welcome back #{user.email}")
    else
      flash[:alert] = 'Oops - a valid login link is required'
      redirect_to(landing_path)
      # when the login request page is built it might make sense to redirect to:
      # redirect_to(new_login_path)
    end
  end

  # allow a user to logout / destroy session if desired
  def destroy
    user = current_user
    if user
      flash[:notice] = "logout successful #{user.email}"
      session[:user_id] = nil
    else
      falsh[:alert] = "Oops, there was a logout problem #{user.email}"
    end
    redirect_to(landing_path)
  end

end
