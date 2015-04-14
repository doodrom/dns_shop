class AddNewColumnToUserOrder < ActiveRecord::Migration
  def change
        add_column :user_orders, :order_item_id, :integer
  end
end
