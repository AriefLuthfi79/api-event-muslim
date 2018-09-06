class User < ApplicationRecord
  include ActiveModel::Validations
  # Getter confirm_token
  # This method should return a valid confirmation token in database
  attr_reader :confirm_token
  # User should has many events
  has_many :events, dependent: :destroy
  
  # User should has many ticket_details
  has_many :ticket_details, class_name: :TicketDetail, foreign_key: :attendee_id, dependent: :destroy
  # User should has many event to be attended
  has_many :active_attends, class_name: "Attendee", foreign_key: "attendee_id", dependent: :destroy
  has_many :attending, through: :active_attends, source: :attended_event
  
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

  # Should generate confirmation token
  before_create :generate_confirmation_token
  # Will downcase email when create user
  before_save :downcase_email

  # Adds user to attend of event
  def attend(event)
    active_attends.create(attended_event_id: event.id)
  end

  # Remove user to attend of event
  def unatend(event)
    active_attends.find_by(attended_event_id: event.id).destroy
  end

  # Selection the user if attended
  def attending?(event)
    attending.include?(event)
  end

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

  # Returns past user's event
  def past_events
    events.where("time_event < ?", Time.now)
  end

  # Returns upcoming user's event
  def upcoming_events
    events.where("time_event > ?", Time.now)
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
