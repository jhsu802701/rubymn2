class CreateSponsors < ActiveRecord::Migration[5.1]
  def change
    create_table :sponsors do |t|
      t.string :name
      t.string :phone
      t.text :description
      t.string :contact_email
      t.string :contact_url
      t.boolean :current

      t.timestamps
    end
  end
end
