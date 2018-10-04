class Api::V1::UsersController < ApplicationController
  # Only specific action must authenticated
  skip_before_action :authenticate_user, only: :create
  # Create user when register
  def create
    user = User.create(user_params)

    if user.save
      # After save sending a mail to user email
      user.send_confirmation_email
      user.mark_as_confirmated!
      render json: { status: { created: I18n.t('user_created.successfully') } }
    else
      render json: { errors: user.errors, status: 422 }
    end
  end

  # Show the current user
  def show_events
    render json: current_user
  end

  # Update the current user
  def update_user
    user = current_user
    if user.update(update_params)
      render json: { status: { updated: "Ok" } }
    else
      render json: user.errors.full_messages
    end
  end

  private

  # Permit the user params
  def user_params
    params.permit(:email, :password, :password_confirmation)
  end

  # Permit the update params
  def update_params
    params.permit(:surname, :bio)
  end
end
