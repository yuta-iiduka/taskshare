class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :title
      t.text :content , default: ""
      t.datetime :start_time
      t.datetime :end_time
      t.string :tasklink , default: ""
      t.integer :user_id
      t.timestamps
    end
  end
end
