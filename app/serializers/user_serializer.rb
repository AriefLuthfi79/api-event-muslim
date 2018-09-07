class UserSerializer < ActiveModel::Serializer
  attributes :id,
  					 :email,
  					 :handled_events,
  					 :attended_events

  def handled_events
  	self.object.events.map do |object|
  		{
  			event_id: object.id,
  			event_name: object.name,
  			event_description: object.description,
  			time_event: object.time_event,
  			disable_event: disabled?(object)
  		}
  	end
  end

  def attended_events
  	self.object.active_attends.map do |object|
  		event = Event.find(object.attended_event_id)
  		{
  			event_id: event.id,
  			event_name: event.name,
  			event_description: event.description,
  			time_event: event.time_event
  		}
  	end
  end

  private

  def disabled?(object)
  	Event.find(object.id).time_event < Time.now
  end
end
