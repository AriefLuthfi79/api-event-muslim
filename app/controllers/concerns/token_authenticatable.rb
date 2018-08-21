class NotAuthorizedException < StandardError; end

module TokenAuthenticatable
  extend ActiveSupport::Concern

  included do
    attr_reader :current_user

    # Authenticate user if not authorized
    before_action :authenticate_user

  rescue_from NotAuthorizedException, with: -> {
    render json: { error: { status: 'Not Authorized' } }
  }
  end

  # Before action authenticate user
  def authenticate_user
    @current_user = DecodeAuthenticatedCommand.call(request.headers).result
    raise NotAuthorizedException unless @current_user
  end
end
