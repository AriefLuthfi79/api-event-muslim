class Attendee < ApplicationRecord
	
	# Attendee has one event to be attended
	belongs_to :attendee, class_name: :User
	belongs_to :attended_event, class_name: :Event

	# Attendee id should be present
	validates :attendee, presence: true
	# Attended event id should be present
	validates :attended_event, presence: true

end
