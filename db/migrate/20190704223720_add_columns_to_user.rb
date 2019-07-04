class AddColumnsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :github_uid, :string
    add_column :users, :github_username, :string
    add_column :users, :github_token, :string
  end
end
