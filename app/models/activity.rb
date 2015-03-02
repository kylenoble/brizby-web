class Activity < ActiveRecord::Base
	geocoded_by [:latitude, :longitude]
	paginates_per 10
end