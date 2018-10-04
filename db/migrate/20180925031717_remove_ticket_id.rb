class RemoveTicketId < ActiveRecord::Migration[5.2]
  def change
  	remove_column :list_attendees, :ticket_id
  end
end
