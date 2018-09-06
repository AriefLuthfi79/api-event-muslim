class AddIndexToTicketId < ActiveRecord::Migration[5.2]
  def change
  	add_index :attendees, :ticket_id
  end
end
