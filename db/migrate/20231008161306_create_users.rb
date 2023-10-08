class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :github_name
      t.text :description
      t.decimal :cached_rating

      t.timestamps
    end
  end
end
