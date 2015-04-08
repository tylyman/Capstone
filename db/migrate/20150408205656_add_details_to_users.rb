class AddDetailsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :admin, :boolean
    add_column :users, :age, :boolean
    add_column :users, :user_name, :string
    add_column :users, :dob, :datetime
  end
end
