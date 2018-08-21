class DecodeAuthenticatedCommand < BaseCommand
  private

  # Getter for header method
  attr_reader :headers

  def initialize(headers)
    @headers = headers
    @user = nil
  end

  # set the result if user is founded
  def payload
    return unless token_present?
    @result = user if user
  end

  # Find the user
  def user
    @user ||= User.find_by(id: decoded_id)
    @user || errors.add(:token, I18n.t('decode_authentication_command.token_invalid'))
  end

  # Return true if token present and token contents present
  def token_present?
    token.present? && token_contents.present?
  end

  # Get token from header
  def token
    return authorization_header.split(' ').last if authorization_header.present?
    errors.add(:token, I18n.t('decode_authentication_command.token_missing'))
    nil
  end

  # Find the token from authorization contents
  def authorization_header
    headers['Authorization']
  end

  # Decoded the token from headers
  def token_contents
    @token_contents ||= begin
      decoded = JwtService.decode(token)
      errors.add(:token, I18n.t('decode_authentication_command.token_expired')) unless decoded
      decoded
    end
  end

  def decoded_id
    token_contents['user_id']
  end
end
