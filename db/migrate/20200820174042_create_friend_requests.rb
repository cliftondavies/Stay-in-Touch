class CreateFriendRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :friend_requests do |t|
      t.integer :befriender_id
      t.integer :befriendee_id
      t.string :status

      t.timestamps
    end
    add_foreign_key :friend_requests, :users, column: :befriender_id
    add_foreign_key :friend_requests, :users, column: :befriendee_id
    add_index :friend_requests, :befriender_id
    add_index :friend_requests, :befriendee_id
  end
end
