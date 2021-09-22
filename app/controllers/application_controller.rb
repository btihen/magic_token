class ApplicationController < ActionController::Base
  before_action :users_only

  def current_user
    # `dig` and `find_by` avoid raising an exception w/o a session
    user_id = session.dig(:user_id)
    @current_user ||= User.find_by(id: user_id)
  end

  private

  # code to ensure only logged in users have access to users pages
  def users_only
    if current_user.blank?
      # send to login page to get an access link
      redirect_back(fallback_location: landing_path,
                    :alert => "Login Required")
      # # uncomment to send people access link page (when built)
      # redirect_back(fallback_location: new_users_login_path,
      #               :alert => "Login Required")
    end
  end
end
