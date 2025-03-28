class ApplicationController < ActionController::Base
  before_action :authenticate
  
  private

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == 'admin' &&
      password == '1234'
    end
  end
  allow_browser versions: :modern
end
