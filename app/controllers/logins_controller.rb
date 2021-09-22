class LoginsController < ApplicationController
  # we need to skip the users only check so this pages can be accessed
  skip_before_action :users_only

  def new
    user = User.new
    render :new, locals: {user: user}
  end

  def create
    email = user_params[:email]

    # we may or may not find a user
    user = User.find_by(email: email)

    # always take the time to calculate token info (discourages email fishing)
    token = SecureRandom.hex(50)
    # besure to use NOW and not NEW!
    token_expires_at = DateTime.now + 1.hour
    token_params = {token: token, token_expires_at: token_expires_at}

    # if we have a user and the update is successful
    if user && user.update(token_params)
      access_url = create_session_url(token: user.token)
      LoginMailer.send_link(user, access_url).deliver_later
    end

    # # uncomment to add noise to discourage response time monitoring
    # # in order to mine user emails
    # mini_wait = Random.new.rand(10..20) / 1000
    # wait(mini_wait)

    # true or not we state we have sent an access link and redirect to the landing page
    # also prevent email fishing by always returning the same answer
    redirect_to(landing_path, notice: "Access-Link has been sent")
  end

  private

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:email)
    end
end
