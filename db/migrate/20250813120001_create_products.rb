class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.decimal :price, precision: 8, scale: 2, null: false
      t.integer :stock_quantity, default: 0
      t.boolean :active, default: true

      t.timestamps
    end

    add_index :products, :name
    add_index :products, :price
    add_index :products, :active
  end
end