class AddActiveUserToSites < ActiveRecord::Migration[6.1]
  def change
    add_column :sites, :active_user, :integer, default: 0, null: false
  end
end
