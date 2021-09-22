class LoginMailer < ApplicationMailer

  def send_link(user, login_url)
    @user = user
    @login_url  = login_url
    host = Rails.application.config.hosts.first

    mail(to: @user.email, subject: "Access-Link for #{host}")
  end

end
