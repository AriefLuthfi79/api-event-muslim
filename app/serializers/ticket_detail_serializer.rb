class TicketDetailSerializer < ActiveModel::Serializer
  attributes :id,
  					 :ticket_name,
  					 :surname

  def ticket_name
  	TicketDetail.find(self.object.id).ticket[:ticket_name]
  end
end
