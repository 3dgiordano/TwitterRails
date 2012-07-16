class CreateTwits < ActiveRecord::Migration
  def change
    create_table :twits do |t|
      t.string :text
      t.integer :user_id
      t.datetime :created_at
    end
  end
end
