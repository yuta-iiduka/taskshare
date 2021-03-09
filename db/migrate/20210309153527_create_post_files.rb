class CreatePostFiles < ActiveRecord::Migration[5.2]
  def change
    create_table :post_files do |t|
      t.string :title
      t.text :introduction
      t.integer :user_id

      t.timestamps
    end
  end
end
