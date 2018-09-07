class Api::V1::AttendeesController < ApplicationController

	# Only create and destroy attending
	def create
		event = Event.find(params[:event_id])
		attend = current_user.attend(event) unless current_user.attending?(event) && is_fulled?(event)
		if attend
			ticket_detail = current_user.ticket_details.create(resource_params(event))
			if ticket_detail
				render json: { status: {
					created: "Ok"
				} }
			end
		else
			render json: { status: I18n.t('attended_event.status') }
		end
	end

	# Will destroying attended event
	def destroy
		begin
			event = Attendee.find(params[:id]).attended_event
			current_user.unattend(event)
		rescue ActiveRecord::RecordNotUnique => e
			render json: { status: "Record not unique" }
		end
	end

	private

	# Will get resource params from form data
	def resource_params(event)
		if params[:email].present?
			params.permit(:email, :surname)
		else
			email = get_params_from_resource(current_user)
			return Hash(email: email, surname: params[:surname], ticket_id: event.ticket.id)
		end
	end

	# Get current_user's email
	def get_params_from_resource(current_user)
		current_user.email
	end

	def is_fulled?(event)
		event.attendees.count > event.ticket[:quantity]
	end
end
