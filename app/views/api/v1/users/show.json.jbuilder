json.id @user.id
json.name @user.name
json.avatar	@user.avatar.image.url(:medium)
json.home_city @user.home_city
json.following @user.following.count
json.followers @user.followers.count
