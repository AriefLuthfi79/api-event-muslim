class Api::V1::TicketDetailsController < ApplicationController

	# Will show all ticket's user
	def index
		ticket_details = current_user.ticket_details
		render json: ticket_details
	end

end
