class AddVotersToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :voters, :integer, array: true, default: []
  end
end
