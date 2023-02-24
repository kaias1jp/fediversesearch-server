class AddTotalUserToSites < ActiveRecord::Migration[6.1]
  def change
    add_column :sites, :total_user, :integer, default: 0, null: false
  end
end
