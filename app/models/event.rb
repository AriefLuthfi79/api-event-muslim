class Event < ApplicationRecord
  # Event should belong to user
  belongs_to :user, primary_key: :id, foreign_key: :user_id, class_name: :User
  # Event only have one image
  has_one_attached :image
  # Before validation correct mime type
  validate :correct_image_mime_type
  validates :name, presence: true, length: { maximum: 300 }

  # Will return order by time (Descending)
  default_scope ->{ order(time_event: :desc) }

  # Will selection time event if expired
  def self.past
    Event.all.where('time_event < ?', Time.now)
  end

  # Get image url from active storage
  def image_uri
    if self.image.attached?
      Rails.application.routes.url_helpers.rails_blob_url(self.image)
    else
      nil
    end
  end

  private
  # Validate image type
  def correct_image_mime_type
    if image.attached? && !image.content_type.in?(%w(image/jpg image/png image/jpeg))
      errors.add(:image, 'Must be a JPG, JPEG or a PNG file')
    end
  end
end
