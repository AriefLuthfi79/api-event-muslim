class CreateListAttendees < ActiveRecord::Migration[5.2]
  def change
    create_table :list_attendees do |t|
    	t.bigint :event_id
    	t.bigint :ticket_id
    	t.string :email

      t.timestamps
    end
  end
end
