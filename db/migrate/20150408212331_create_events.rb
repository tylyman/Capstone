class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.datetime :datetime
      t.string :city
      t.string :state
      t.integer :cost
      t.integer :vacancies

      t.timestamps null: false
    end
  end
end
