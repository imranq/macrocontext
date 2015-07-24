module ApplicationHelper
	def chartdata(series_id)
		SeriesDatum.where(:series_id => series_id, :date => 10.year.ago..Time.now).group_by_year(:date, "avg", :value) #dateslice method
	end


end
