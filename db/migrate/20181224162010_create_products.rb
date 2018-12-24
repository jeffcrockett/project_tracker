class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.decimal :price, precision: 10, scale: 2
      t.decimal :cogs, precision: 10, scale: 2

      t.timestamps
    end
    add_index :products, :name, unique: true
  end
end
