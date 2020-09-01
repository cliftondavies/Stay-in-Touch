class DropJoinTableFriendUser < ActiveRecord::Migration[5.2]
  def change
    drop_join_table :friends, :users
  end
end
