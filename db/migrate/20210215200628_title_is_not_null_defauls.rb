class TitleIsNotNullDefauls < ActiveRecord::Migration[6.1]
  def change
    change_column_default :sites, :title, from: nil, to: ""
  end
end
