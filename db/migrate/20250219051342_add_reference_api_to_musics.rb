class AddReferenceApiToMusics < ActiveRecord::Migration[7.2]
  def change
    add_column :musics, :reference_api, :string
  end
end
