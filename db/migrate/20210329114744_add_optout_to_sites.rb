class AddOptoutToSites < ActiveRecord::Migration[6.1]
  def change
    add_column :sites, :optout, :boolean, default: false, null: false
  end
end
