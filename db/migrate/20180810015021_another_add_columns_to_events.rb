class AnotherAddColumnsToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :time_event, :datetime
  end
end
