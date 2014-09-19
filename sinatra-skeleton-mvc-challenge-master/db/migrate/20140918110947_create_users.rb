class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :full_name, uniqueness: true
      t.string :password
      t.string :about_me
      t.string :email
      t.timestamps
    end
  end
end
