class CreateBlahs < ActiveRecord::Migration
  def change
    create_table :blahs do |t|
      t.string :content, limit: 140
      t.belongs_to :user
      t.timestamps
    end
  end
end
