class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.integer :album_id, null: false
      t.string :title, null: false
      t.boolean :bonus
      t.text :lyrics

      t.timestamps null: false
    end

    add_index :tracks, :album_id
  end
end
