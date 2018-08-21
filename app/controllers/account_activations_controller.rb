class AccountActivationsController < ApplicationController
  skip_before_action :authenticate_user

  # Confirm an email
  def confirm_email
    token = params[:token].to_s

    user = User.find_by(confirmation_token: token)

    if user.confirmation_token_valid?
      user.mark_as_confirmated!
      render json: { status: I18n.t('account_activation.status') }
    else
      render json: { status: { errors: "Not confirmated" } }
    end
  end
end
