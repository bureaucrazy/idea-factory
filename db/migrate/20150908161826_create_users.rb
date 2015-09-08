class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.text :email
      t.string :password
      t.string :name

      t.timestamps null: false
    end
  end
end
