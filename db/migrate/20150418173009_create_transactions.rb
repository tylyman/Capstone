class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :stripe_id
      t.integer :user_id
      t.integer :amount
      t.boolean :paid
      t.integer :course_id

      t.timestamps null: false
    end
  end
end
