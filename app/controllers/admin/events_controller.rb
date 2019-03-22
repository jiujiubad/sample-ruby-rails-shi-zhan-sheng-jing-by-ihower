class Admin::EventsController < ApplicationController
  before_action :authenticate
  layout 'admin'

  def index
    @events = Events.all
  end

  private

  def authenticate
    authenticate_or_request_with_http_basic do |user_name, password|
      user_name = "user_name" && password == "password"
    end
  end
end