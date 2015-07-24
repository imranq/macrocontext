class Series < ActiveRecord::Base
	has_many :datum


	def self.search(search)
	    if search
	      	result = where('LOWER(description) LIKE LOWER(:search) or LOWER(title) LIKE LOWER(:search)', search: "%#{search}%")
	    else
	      scoped
	    end 
	end
end
