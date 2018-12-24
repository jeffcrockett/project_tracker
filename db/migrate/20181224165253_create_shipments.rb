class CreateShipments < ActiveRecord::Migration[5.2]
  def change
    create_table :shipments do |t|
      t.references :project, foreign_key: true
      t.references :product, foreign_key: true
      t.integer :quantity
      t.decimal :cable_length, precision: 5, scale: 1
      t.decimal :price, precision: 10, scale: 2
      t.date :date
      t.text :notes

      t.timestamps
    end
  end
end
