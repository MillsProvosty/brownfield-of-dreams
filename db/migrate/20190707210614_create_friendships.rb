class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.references :user, index: true, foreign_key: true
      t.references :friended_user, index: true
      t.timestamps
    end

    add_foreign_key :friendships, :users, column: :friended_user_id
    add_index :friendships, [:user_id, :friended_user_id], unique: true
  end
end
