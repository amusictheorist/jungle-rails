class AddIndexToUsersEmail < ActiveRecord::Migration[6.1]
  def change
    add_index :users, 'lower(email)', unique: true, name: 'index_users_on_lowercase_email'
  end
end
