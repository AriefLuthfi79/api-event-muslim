class CreateTickets < ActiveRecord::Migration[5.2]
  def change
    create_table :tickets do |t|
    	t.bigint :event_id
    	t.string :ticket_name
    	t.text 	 :ticket_description
    	t.bigint :quantity

      t.timestamps
    end

    add_index :tickets, :event_id, unique: true
  end
end
