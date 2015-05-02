class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :address
      t.datetime :ended_at
      t.float :lat
      t.float :lon
      t.string :name
      t.datetime :started_at
      t.belongs_to :owner, index: true

      t.timestamps null: false
    end
  end
end
