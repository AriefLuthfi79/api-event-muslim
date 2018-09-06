class ChangeColumnAttendee < ActiveRecord::Migration[5.2]
  def self.up
  	rename_column :attendees, :event_id, :attended_event_id
  	rename_column :attendees, :user_id, :attendee_id
  end
end
