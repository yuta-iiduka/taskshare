class ChangeTagmapPostFilesTotagmapPostfiles < ActiveRecord::Migration[5.2]
  def change
    rename_table :tagmap_post_files, :tagmap_postfile
  end
end
