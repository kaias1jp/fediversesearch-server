class AddFullTextSearchIndexToSites < ActiveRecord::Migration[6.1]
  def change
    enable_extension 'pgroonga'
    add_index(:sites, :title, using: "pgroonga")
    add_index(:sites, :description, using: "pgroonga")
  end
end
