class TicketDetails < ActiveRecord::Migration[5.2]
  def change
  	
  	create_table :ticket_details do |t|
  		t.bigint :ticket_id
  		t.bigint :attendee_id
  		t.string :email
  		t.string :surname
  	end
  	
  	add_index :ticket_details, :email
  	add_index :ticket_details, :attendee_id
  	add_index :ticket_details, :ticket_id
  end
end
