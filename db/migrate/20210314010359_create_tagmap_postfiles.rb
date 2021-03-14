class CreateTagmapPostfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :tagmap_post_files do |t|
      t.references :post_file, foreign_key: true
      t.references :tag, foreign_key: true

      t.timestamps
    end
    add_index :tagmap_post_files, [:post_file_id,:tag_id], unique: true
  end
end
