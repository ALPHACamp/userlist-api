class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :surname
      t.string :email
      t.string :gender
      t.integer :age
      t.string :region
      t.string :birthday
      t.string :avatar
      t.timestamps
    end
  end
end
