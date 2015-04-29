class AddEventNameToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :event_name, :string
  end
end
