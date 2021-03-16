class CreateMemos < ActiveRecord::Migration[5.2]
  def change
    create_table :memos do |t|
      t.text :memotext
      t.integer :user_id

      t.timestamps
    end
  end
end
