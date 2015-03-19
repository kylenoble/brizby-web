class Activity < ActiveRecord::Base
	geocoded_by [:latitude, :longitude]
	max_paginates_per 50
end