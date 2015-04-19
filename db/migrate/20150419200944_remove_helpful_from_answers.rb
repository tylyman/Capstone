class RemoveHelpfulFromAnswers < ActiveRecord::Migration
  def change
    remove_column :answers, :helpful, :integer
  end
end
