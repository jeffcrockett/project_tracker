class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.string :name
      t.boolean :closed
      t.integer :confidence
      t.references :distributor, foreign_key: true
      t.string :rep
      t.string :payment_terms
      t.string :integer
      t.text :notes

      t.timestamps
    end
    add_index :projects, :name, unique: true
  end
end
