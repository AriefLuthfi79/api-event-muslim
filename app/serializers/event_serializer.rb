class EventSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :description,
             :time,
             :date,
             :time_event,
             :place,
             :image,
             :user

  def user
    {
      user_id: self.object.user.id,
      email: self.object.user.email
    }
  end

  def image
    self.object.image_uri
  end
end
