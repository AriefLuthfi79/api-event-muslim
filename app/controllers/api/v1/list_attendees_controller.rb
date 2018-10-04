class Api::V1::ListAttendeesController < ApplicationController

	def create
		list = ListAttendee.new(list_params)
		if list.save
			render json: { status: "Created Ok" }
		else
			render json: { errors: list.errors, status: 422 }
		end
	end

	def show_list
		lists = Event.find(params[:event_id]).list_attendees
		render json: { lists: lists }
	end

	private

	def list_params
		params.permit(:email, :event_id)
	end
end