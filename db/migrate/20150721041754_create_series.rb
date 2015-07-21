class CreateSeries < ActiveRecord::Migration
  def change
    create_table :series do |t|
      t.text :title
      t.text :series_id
      t.text :description
      t.text :source
      t.text :periodicity
      
      t.timestamps null: false
    end
  end
end
