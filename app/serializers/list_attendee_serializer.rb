class ListAttendeeSerializer < ActiveModel::Serializer
  attributes :id, :email, :event_id
end
