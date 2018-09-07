class Ticket < ApplicationRecord
	# Ticket should be belongs to event
	belongs_to :event, :class_name => :Event
	# Ticket should has one ticket_detail
	has_many :ticket_details, foreign_key: :ticket_id, class_name: :TicketDetail, dependent: :destroy

	validates :ticket_name, presence: true
	validates :ticket_description, presence: true

end
