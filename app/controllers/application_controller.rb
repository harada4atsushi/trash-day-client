class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception
  # protect_from_forgery with: :null_session
  # skip_before_filter :verify_authenticity_token
  before_action :authenticate_user!
end
