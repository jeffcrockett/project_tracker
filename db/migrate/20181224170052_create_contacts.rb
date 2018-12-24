class CreateContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :contacts do |t|
      t.references :distributor, foreign_key: true
      t.string :name
      t.string :email
      t.string :phone
      t.text :notes

      t.timestamps
    end
    add_index :contacts, :name, unique: true
  end
end
