class RemoveQuantityInTicket < ActiveRecord::Migration[5.2]
  def change
  	remove_column :tickets, :quantity	
  end
end
