json.results 
	json.users @users do |user|
		json.id user.id
		json.name user.name
		json.avatar	user.avatar.image.url(:medium)
		if user.has_attribute?(:category)
			json.type "business"
		else
			json.type "user"
		end
	end