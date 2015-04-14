class CreateUserOrders < ActiveRecord::Migration
  def change
    create_table :user_orders do |t|
      t.integer :user_id
      t.integer :order_id
      t.integer :order_item_id
      t.integer :orderItem_id

      t.timestamps null: false
    end
  end
end
