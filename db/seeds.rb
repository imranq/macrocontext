# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# need to normalize periodicity and a way to map changes from api level to server level

def initialize_fred_data
	init_series = [	"cpiaucsl","cpiappsl","cpf3m","cp","compout","ccsa","ccfc","cbi","businv","borrow","bopxrt","bopxgs","bopmit","bopmgs","bopio","bopi","bopgstb","bopg","boperr","bopcat","bopbsv","bopbm","bopbii","bopbgs","bopbca","awhi"]


	#Data.delete.all
	fred = Fred::Client.new(:api_key => 'a62978cb13e71a0e3efb54462b253d47')
	init_series.each do |sid|
		series_info = fred.series(nil, :series_id => sid).seriess.series
		
		#create series unless its already in the database (unlikely since this is a seed, but you never know)
		#if !Series.find(:series_id => sid).blank?
			Series.create!(:series_id => sid, :title => series_info.title, :source => "FRED", :periodicity => series_info.frequency)
			
			observations = fred.series('observations', :series_id => sid).observations.observation

			observations.each do |entry|
				date = DateTime.parse(entry.date)
				#if SeriesDatum.find(:series_id => sid, :date => date).blank?
				newdata = SeriesDatum.new(:series_id => sid, :date => date, :value => entry.value)
				newdata.save
				#end
			end
		#end
	end
end

initialize_fred_data

# series names

# wtermfac,
# wtalf,
# wresbal,
# wrepo,
# wpcredit,
# wmaiden1,
# wgsyld,
# wgs7yr,
# wgs6mo,
# wgs5yr,
# wgs3mo,
# wgs30yr,
# wgs2yr,
# wgs20yr,
# wgs1yr,
# wgs10yr,
# wgoldprice,
# wcurcir,
# wbaa
# waaa,
# unrate,
# umcsent,
# twexb,
# treast,
# totalsl,
# termauc,
# template,
# tcutest,
# tcu
# tb3ms,
# taylor,
# spxm
# spx,
# rsafs,
# rrsfs,
# realln,
# psavert,
# ppilfe,
# ppifgs,
# ppicpe,
# ppicem,
# ppiaco,
# pop
# pi,
# permit,
# pces
# pcend,
# pcecc96,
# pcec96,
# pce
# payems,
# ophnfb,
# oilprice,
# netexc,
# napmsdi,
# napmpi,
# napmnoi,
# napmci,
# napmbi,
# napm
# mult,
# mpcredit,
# mortg,
# mich
# mbst,
# manemp,
# m3
# m2,
# m1,
# libor3mw_wgs3mo,
# libor3mw,
# iursa,
# isratio,
# iputil,
# ipmine,
# ipmat,
# ipman,
# ipcongd,
# ipbuseq,
# indpro,
# icsa
# ic4wsa,
# hsn1f,
# houst,
# gpdic96,
# goldprice,
# gnpc96,
# gdppot,
# gdpic1,
# gdpdef,
# gdpcomp,
# gdpc96,
# gdp
# gcec1,
# gasprice,
# fygfdpun,
# fgce
# ff,
# exusuk,
# exuseu,
# exjpus,
# exhkus,
# exchus,
# excaus,
# ecomsa,
# dspic96,
# dgorder,
# cumfn,
# cscp10,
# cpitrnsl,
# cpirecsl,
# cpimedsl,
# cpilfesl,
# cpihossl,
# cpifabsl,
# cpiengsl,
# cpiedusl,
# cpiaucsl,
# cpiappsl,
# cpf3m,
# cp
# compout,
# ccsa
# ccfc,
# cbi,
# businv,
# borrow,
# bopxrt,
# bopxgs,
# bopmit,
# bopmgs,
# bopio,
# bopi
# bopgstb,
# bopg
# boperr,
# bopcat,
# bopbsv,
# bopbm,
# bopbii,
# bopbgs,
# bopbca,
# awhi,
