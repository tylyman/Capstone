class AddAdminCodeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :admin_code, :string
  end
end
