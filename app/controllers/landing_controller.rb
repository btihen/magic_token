class LandingController < ApplicationController
  skip_before_action :users_only
  def index
  end
end
