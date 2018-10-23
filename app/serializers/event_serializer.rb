class EventSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :description,
             :time,
             :date,
             :time_event,
             :place,
             :quantity,
             :total_registered,
             :image,
             :registered,
             :user,
             :longitude,
             :latitude

  def user
    {
      user_id: self.object.user.id,
      email: self.object.user.email
    }
  end

  def registered
    self.object.passive_attends.map do |object|
      user = User.find(object.attendee_id)
      {
        user_id: user.id,
        email: user.email
      }
    end
  end

  def total_registered
    self.object.attendees.ids.count
  end

  def image
    Rails.application.routes.url_helpers.rails_blob_url(self.object.image)
  end
end
