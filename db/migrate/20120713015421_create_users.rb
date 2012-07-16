class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :screen_name
      t.string :name
      t.integer :followers_count

      t.timestamps
    end
  end
end
