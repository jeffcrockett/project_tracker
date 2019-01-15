class AddMinConfidenceToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :min_confidence, :fixnum
  end
end
