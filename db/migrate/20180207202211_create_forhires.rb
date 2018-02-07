class CreateForhires < ActiveRecord::Migration[5.1]
  def change
    create_table :forhires do |t|
      t.text :description
      t.string :email
      t.string :title
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :forhires, [:user_id, :created_at]
  end
end
