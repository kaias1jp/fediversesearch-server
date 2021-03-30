class AddColumnGetPeerStatus < ActiveRecord::Migration[6.1]
  def change
    add_column :sites, :get_peer_status, :boolean
  end
end
