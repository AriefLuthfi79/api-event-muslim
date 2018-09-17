class ApplicationController < ActionController::API
  include TokenAuthenticatable

  rescue_from ActiveRecord::RecordNotFound, with: ->{ render json: {
    error: 'Not Found'}, status: :not_found
  }

  def logged_in?
  	!current_user.nil?
  end
end
