class CreateCartItems < ActiveRecord::Migration[8.0]
  def change
    create_table :cart_items do |t|
      t.references :product, null: false, foreign_key: true
      t.references :user, null: true, foreign_key: { to_table: :admin_users }
      t.string :session_id
      t.integer :quantity, default: 1

      t.timestamps
    end

    add_index :cart_items, :session_id
    add_index :cart_items, [:user_id, :product_id]
  end
end