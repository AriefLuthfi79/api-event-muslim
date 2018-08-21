class Api::V1::UsersController < ApplicationController
  # Only specific action must authenticated
  skip_before_action :authenticate_user

  def create
    user = User.create(user_params)

    if user.save
      # After save sending a mail to user email
      user.send_confirmation_email
      render json: { status: { created: I18n.t('user_created.successfully') } }
    else
      render json: { errors: user.errors, status: 422 }
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end
