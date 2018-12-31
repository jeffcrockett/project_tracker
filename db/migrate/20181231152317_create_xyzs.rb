class CreateXyzs < ActiveRecord::Migration[5.2]
  def change
    create_table :xyzs do |t|

      t.timestamps
    end
  end
end
