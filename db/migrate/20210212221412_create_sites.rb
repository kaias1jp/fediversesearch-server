class CreateSites < ActiveRecord::Migration[6.1]
  def change
    create_table :sites do |t|
      t.string :uri
      t.references :software, null: false, foreign_key: true
      t.string :title
      t.string :short_description
      t.text :description
      t.boolean :registrations
      t.string :thumbnail
      t.string :dns_status
      t.integer :http_status
      t.timestamp :last_confirmation_date

      t.timestamps
    end
  end
end
