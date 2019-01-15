class AddMaxConfidenceToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :max_confidence, :fixnum
  end
end
