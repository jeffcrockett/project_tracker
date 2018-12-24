class CreateRegistrations < ActiveRecord::Migration[5.2]
  def change
    create_table :registrations do |t|
      t.references :project, foreign_key: true
      t.references :contact, foreign_key: true
      t.date :expiration
      t.text :notes

      t.timestamps
    end
  end
end
