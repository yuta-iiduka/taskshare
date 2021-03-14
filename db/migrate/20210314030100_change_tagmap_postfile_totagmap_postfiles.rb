class ChangeTagmapPostfileTotagmapPostfiles < ActiveRecord::Migration[5.2]
  def change
    rename_table :tagmap_postfile, :tagmap_postfiles
  end
end
