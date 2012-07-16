class CreateTrendsTwitts < ActiveRecord::Migration
  def change
    create_table :trends_twits, :id => false do |t|
      t.integer :trend_id
      t.integer :twit_id
    end
  end
end
