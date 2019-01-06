class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :password_digest
      t.boolean :admin
      t.boolean :exec

      t.timestamps
    end
    add_index :users, :name, unique: true
  end
end
