json.lovers @lovers do |user|
	json.id user.id
	json.name user.name
	json.avatar	user.avatar.image.url(:medium)
end