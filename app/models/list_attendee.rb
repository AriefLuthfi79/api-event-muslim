class ListAttendee < ApplicationRecord
	belongs_to :event, foreign_key: :event_id, class_name: :Event
end
