class TicketDetail < ApplicationRecord

	# Ticket details should belongs to User a.k.a attendee_id
	belongs_to :attendee, class_name: :User
	# Ticket Details should belongs_to ticket
	belongs_to :ticket, class_name: :Ticket

end