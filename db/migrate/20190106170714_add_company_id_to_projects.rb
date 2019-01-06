class AddCompanyIdToProjects < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :company_id, :integer
  end
end
