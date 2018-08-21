class Api::V1::AuthController < ApplicationController
  # Only specific action must authenticated
  skip_before_action :authenticate_user, only: :create

  def create
    token = AuthenticatedUserCommand.call(auth_params)

    if token.success?
      render json: { token: token.result, user_id: JwtService.decode(token.result) }
    else
      render json: { status: { error: token.errors } }
    end
  end

  private

  def auth_params
    params.require(:auth).permit(:email, :password)
  end
end
