class LoginsController < ApplicationController
  # we need to skip the users only check so this pages can be accessed
  skip_before_action :users_only

  def new
    user = User.new
    render :new, locals: {user: user}
  end

  def create
    email = user_params[:email]
    ip_address = request.remote_ip
    # the participant might already exist in our db or possimagic_link_url = participants_session_auth_url(token: participant.login_token)bly a new participant
    user = User.find_by(email: email)
    token = SecureRandom.hex(100)
    token_expires_at = DateTime.new + 1.hour

    if user && user.update_attributes(token: token, token_expires_at: token_expires_at)
      access_url = create_session_url(token: user.token)
      LinkMailer.send_link(user, access_url).deliver_later
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
