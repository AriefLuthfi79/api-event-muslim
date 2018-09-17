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
  			image: image(object.image),
  			place: object.place,
  			disable_event: disabled?(object),
  			registered: attends(object)
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
				image: image(object.image),
				place: object.place
			}
		end
  end

  private

  def attends(object)
  	Event.find(object.id).attendees.map do |obj|
  		{
  			user_id: obj.id,
  			email: obj.email
  		}	
  	end
  end

  def image(image)
    Rails.application.routes.url_helpers.rails_blob_url(image)
  end

  def disabled?(object)
  	Event.find(object.id).time_event <= Time.now
  end
end
