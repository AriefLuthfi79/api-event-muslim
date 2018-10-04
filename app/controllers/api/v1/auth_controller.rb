class Api::V1::AuthController < ApplicationController
  # Only specific action must authenticated
  skip_before_action :authenticate_user, only: :create

  def create
    token = AuthenticatedUserCommand.call(auth_params)

    if token.success?
      user = JwtService.decode(token.result)
      render json: { token: token.result, user_id: user, email: find_user_email(user[:user_id]) }
    else
      render json: { status: { error: token.errors } }
    end
  end

  private

  def auth_params
    params.permit(:email, :password)
  end

  def find_user_email(id)
    User.find(id).email
  end
end
