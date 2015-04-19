class AddHelpfulToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :helpful, :integer, :default => 0
  end
end
