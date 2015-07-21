json.array!(@series) do |series|
  json.extract! series, :id, :title, :series_id, :source
  json.url series_url(series, format: :json)
end
