class Api::V1::EventsController < ApplicationController
  # Only specific action must authenticated
  skip_before_action :authenticate_user, only: [:index, :show]
  before_action :load_resource

  # Shows all events in home
  def index
    events = Event.all
    render json: events, each_serializer: EventSerializer
  end

  # Show specific event if clicked
  def show
    render json: @event
  end

  # Show specific event's user
  def show_events
    render json: @event
  end

  # User can create new event
  def create
    @event.user_id = current_user.id
    if @event.save
      render json: { status: { created: "OK" } }
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  private

  # Get parameter to permit
  def new_event
    Event.new(event_params)
  end

  # Load resource before action
  def load_resource
    case params[:action].to_sym
    when :create
      @event = new_event
    when :show
      @event = Event.find(params[:id])
    when :show_events
      @event = current_user.events.all
    end
  end

  def event_params
    params.permit(:name,
                  :description,
                  :date,
                  :time_event,
                  :image,
                  :time,
                  :place)
  end
end
