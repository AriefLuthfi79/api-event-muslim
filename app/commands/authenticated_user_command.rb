class AuthenticatedUserCommand < BaseCommand

  private

  # Getter for email and password
  attr_reader :email, :password

  def initialize(opt = {})
    @email = opt[:email]
    @password = opt[:password]
  end

  # Get User from database
  def user
    @user ||= User.find_by(email: email)
  end

  # Check if password valid
  def password_valid?
    user &&
    user.authenticate(password) &&
    user.confirmated_at?
  end

  def payload
    if password_valid?
      @result = JwtService.encode(contents)
    else
      errors.add(:base, I18n.t('authenticate_user_command.invalid'))
    end
  end

  # Contents of http request
  # Problem now, how to check expiration
  def contents
    {
      user_id: user.id,
    }
  end
end
