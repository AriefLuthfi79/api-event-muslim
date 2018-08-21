class UserMailer < ApplicationMailer

  # Send confirmation token to user email
  def account_activation(user)
    @user = user
    mail to: user.email, subject: "Account Activation"
  end
end
