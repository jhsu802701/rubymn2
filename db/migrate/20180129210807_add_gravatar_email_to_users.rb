class AddGravatarEmailToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :gravatar_email, :string
  end
end
