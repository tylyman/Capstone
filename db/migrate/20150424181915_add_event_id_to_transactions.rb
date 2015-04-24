class AddEventIdToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :event_id, :integer
  end
end
