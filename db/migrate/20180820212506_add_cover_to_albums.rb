class AddCoverToAlbums < ActiveRecord::Migration[5.2]
  def change
    add_column :albums, :cover, :string
  end
end
