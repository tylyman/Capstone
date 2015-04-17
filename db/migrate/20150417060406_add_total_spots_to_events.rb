class AddTotalSpotsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :total_spots, :integer
  end
end
