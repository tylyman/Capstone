class AddEventsOwnerToEvents < ActiveRecord::Migration
  def change
    add_column :events, :events_owner_id, :integer
  end
end
