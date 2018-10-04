class Event < ApplicationRecord
  # Event should belong to user
  belongs_to :user, primary_key: :id, foreign_key: :user_id, class_name: :User
  # Event only have one image
  has_one_attached :image
  
  # Event should has many attendees
  has_many :list_attendees, class_name: :ListAttendee, dependent: :destroy
  has_many :passive_attends, class_name: :Attendee, foreign_key: :attended_event_id, dependent: :destroy
  has_many :attendees, through: :passive_attends, source: :attendee
  
  # Event should has one ticket
  has_one :ticket, class_name: :Ticket, foreign_key: :event_id, dependent: :destroy

  # Before validation correct mime type
  validate :correct_image_mime_type
  validates :name, presence: true, length: { maximum: 300 }

  # After validation title should be titleize
  after_validation :normalize_titleize
  
  # Will return order by time (Descending)
  default_scope ->{ order(time_event: :desc) }
  scope :evaluate_event, ->{ where("time_event > ?", Time.now.advance(days: -1)) }

  # Will selection time event if expired
  def past
    Event.all.where('time_event < ?', Time.now)
  end

  # Will selection valid date
  def has_valid_date?
    self.time_event < Time.now.advance(days: 1)
  end

  # Get mage url from active storage
  # def image_uri
  #   if self.image.attached?
  #     Rails.application.routes.url_helpers.rails_blob_url(self.image)
  #   else
  #     nil
  #   end
  # end

  def disabled?
    self.time_event <= Time.now
  end

  private
  # Validate image type
  def correct_image_mime_type
    if image.attached? && !image.content_type.in?(%w(image/jpg image/png image/jpeg))
      errors.add(:image, 'Must be a JPG, JPEG or a PNG file')
    end
  end

  # Normalize title case
  def normalize_titleize
    self.name = name.downcase.titleize
  end
end
