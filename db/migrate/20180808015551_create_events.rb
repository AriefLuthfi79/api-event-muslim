class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.bigint :user_id
      t.string :name, null: false
      t.text :description, null: false
      t.datetime :date, null: false

      t.timestamps
    end

    add_index :events, :user_id
  end
end
