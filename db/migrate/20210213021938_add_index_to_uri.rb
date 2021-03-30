class AddIndexToUri < ActiveRecord::Migration[6.1]
  def change
    add_index :sites, :uri, unique: true
  end
end
