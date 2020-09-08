class CreateJoinTableFriendUser < ActiveRecord::Migration[5.2]
  def change
    create_join_table :friends, :users do |t|
      t.references :user, index: :false, foreign_key: :true
      t.references :friend, index: :false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
