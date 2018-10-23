class AddLattitudeLongitude < ActiveRecord::Migration[5.2]
  def change
    add_column :table_name, :latitude, :decimal, {:precision=>10, :scale=>6}
    add_column :event, :longitude, :decimal, {:precision=>10, :scale=>6}
  end
end
