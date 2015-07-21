# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



def initialize_fred_data
	init_series = ["gnpa"]


	#Data.delete.all
	fred = Fred::Client.new(:api_key => 'a62978cb13e71a0e3efb54462b253d47')
	init_series.each do |sid|
		series_info = fred.series(nil, :series_id => sid).seriess.series
		
		#create series unless its already in the database (unlikely since this is a seed, but you never know)
		if !Series.find(:series_id => sid).blank?
			Series.create!(:series_id => sid, :title => series_info.title, :source => "FRED", :periodicity => series_info.frequency)
			
			observations = fred.series('observations', :series_id => sid).observations.observation

			observations.each do |entry|
				date = DateTime.parse(entry.date)
				if SeriesDatum.find(:series_id => sid, :date => date).blank?
					newdata = SeriesDatum.new(:series_id => sid, :date => date, :value => entry.value)
					newdata.save
				end
			end
		end
	end
end

initialize_fred_data