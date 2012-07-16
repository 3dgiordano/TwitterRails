class CreateTrends < ActiveRecord::Migration
  def change
    create_table :trends do |t|
      t.string :name
      t.string :query
      t.datetime :as_of
      t.timestamps
    end
  end
end
