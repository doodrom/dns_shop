class AddNewColumnToUserOrderTwo < ActiveRecord::Migration
  def change
      add_column :user_orders, :orderItem_id, :integer
  end
end
