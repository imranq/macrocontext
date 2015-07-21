class CreateSeriesData < ActiveRecord::Migration
  def change
    create_table :series_data do |t|
      t.text :series_id
      t.timestamp :date
      t.float :value

      t.timestamps null: false
    end
  end
end
