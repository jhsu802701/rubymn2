class AddPictureToSponsors < ActiveRecord::Migration[5.1]
  def change
    add_column :sponsors, :picture, :string
  end
end
