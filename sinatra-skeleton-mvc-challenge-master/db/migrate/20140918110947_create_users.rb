class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :full_name
      t.string :password
      t.string :about_me
      t.timestamps
    end
  end
end
