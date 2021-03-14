class CreateTagmapEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :tagmap_events do |t|
      t.references :event, foreign_key: true
      t.references :tag, foreign_key: true

      t.timestamps
    end
  end
end
