class User < ApplicationRecord
  include ActiveModel::Validations
  # Getter confirm_token
  # This method should return a valid confirmation token in database
  attr_reader :confirm_token
  # User should has many events
  has_many :events, dependent: :destroy

  validates_with EmailValidator

  VALID_PASSWORD_REGEX = /\A
    (?=.*[A-Z])        # Must contain a upper case character
    (?=.*[[:^alnum:]]) # Must contain a symbol
  /x
  has_secure_password
  validates :password, presence: true,
                       length: { minimum: 6 },
                       format: { with: VALID_PASSWORD_REGEX },
                       allow_nil: true
  validates_presence_of :email
  validates_uniqueness_of :email, case_sensitive: false

  before_create :generate_confirmation_token
  before_save :downcase_email

  # If user clicked a mail url, set token confirmation to nil
  # and then set time confirmation_at now
  def mark_as_confirmated!
    update_attribute(:confirmation_token, nil)
    update_attribute(:confirmated_at, Time.now)
  end

  # Send confirmation email
  def send_confirmation_email
    UserMailer.account_activation(self).deliver_now
  end

  # If confirmation token expired? Use this method to check it out
  def confirmation_token_valid?
    (self.confirmation_sent_at + 30.days) > Time.now
  end

  private

  # Will generate confirmation token by using SecureRandom
  def generate_confirmation_token
    self.confirmation_token = @confirm_token = SecureRandom.hex(10)
    self.confirmation_sent_at = Time.now
  end

  # Downcase the email before saving it to database
  def downcase_email
    self.email = email.downcase
  end
end
