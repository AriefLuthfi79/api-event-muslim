class AddColumnsToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :place, :string
    add_column :events, :time, :datetime
  end
end
