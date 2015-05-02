class CreateAttendances < ActiveRecord::Migration
  def change
    create_table :attendances do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :event, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
