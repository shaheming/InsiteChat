class AddIndexToFriendShips < ActiveRecord::Migration[5.0]
  def change
    add_index :friend_ships, [:user_id, :friend_id], :unique => true
  end
end
