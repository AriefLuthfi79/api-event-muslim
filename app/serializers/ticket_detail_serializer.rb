class TicketDetailSerializer < ActiveModel::Serializer
  attributes :id,
  					 :ticket_name,

  def ticket_name
  	TicketDetail.find(self.object.id).ticket[:ticket_name]
  end

end
