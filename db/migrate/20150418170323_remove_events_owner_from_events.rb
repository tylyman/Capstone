class RemoveEventsOwnerFromEvents < ActiveRecord::Migration
  def change
    remove_column :events, :events_owner, :integer
  end
end
