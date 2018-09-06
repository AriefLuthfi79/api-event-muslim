class CreateAttendees < ActiveRecord::Migration[5.2]
  def change
    create_table :attendees do |t|
    	t.bigint :event_id
    	t.bigint :user_id

      t.timestamps
    end
  end
end
