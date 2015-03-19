json.results 
	if @businesses
		json.businesses @businesses do |business|
			json.id business.id
			json.name business.name
			json.avatar	business.avatar.image.url(:medium)
		end
	elsif @users
		json.users @users do |user|
			json.id user.id
			json.name user.name
			json.avatar	user.avatar.image.url(:medium)
		end
	else
		[]
	end