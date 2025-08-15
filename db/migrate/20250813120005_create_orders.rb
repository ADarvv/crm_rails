class CreateOrders < ActiveRecord::Migration[8.0]
  def change
    create_table :orders do |t|
      t.references :user, null: true, foreign_key: { to_table: :admin_users }
      t.string :email, null: false
      t.string :first_name
      t.string :last_name
      t.text :address
      t.string :city
      t.string :province
      t.string :postal_code
      t.string :status, default: 'pending'
      t.decimal :total_amount, precision: 8, scale: 2

      t.timestamps
    end

    add_index :orders, :email
    add_index :orders, :status
    add_index :orders, :created_at
  end
end