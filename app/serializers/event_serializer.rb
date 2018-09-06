class EventSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :description,
             :time,
             :date,
             :time_event,
             :place,
             :total_registered,
             :quantity,
             :image,
             :registered,
             :user

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

  def quantity
    Event.find(self.object.id).ticket[:quantity]
  end

  def image
    self.object.image_uri
  end
end
