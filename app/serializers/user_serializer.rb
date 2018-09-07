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
  			date: object.date,
  			image: object.image_uri,
  			disable_event: disabled?(object)
  		}
  	end
  end

  def attended_events
  	self.object.attending.map do |object|
	  	{
	  		event_id: object.id,
				event_name: object.name,
				event_description: object.description,
				time_event: object.time_event,
				date: object.date,
				image: object.image_uri
			}
		end
  end

  private

  def disabled?(object)
  	Event.find(object.id).time_event < Time.now
  end
end
