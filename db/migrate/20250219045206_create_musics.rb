class CreateMusics < ActiveRecord::Migration[7.2]
  def change
    create_table :musics do |t|
      t.string :title
      t.string :author
      t.string :album
      t.string :duration

      t.timestamps
    end
  end
end
