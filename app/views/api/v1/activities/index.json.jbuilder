json.feed @activities do |activity|
  json.activity_type activity.key
  json.time activity.created_at
  if activity.trackable_type == 'Deal'
    @deal = Deal.find(activity.trackable_id)
    @business = Business.find(activity.owner_id)
  	json.deal do
  		json.cache! @deal do
      	json.partial! @deal
    	end
    end
    json.business do
      json.cache! @business do
      	json.partial! @business
    	end
    end
  elsif activity.trackable_type == 'Friendship'
    @follower = User.find(activity.owner_id)
    @followee = User.find(activity.recipient_id)
  	json.follower do
      json.id @follower.id
      json.name @follower.name
    end 
    json.followee do
      json.id @followee.id
      json.name @followee.name
    end 
  else
    @deal = Deal.find(activity.recipient_id)
    @comment =  Comment.find(activity.trackable_id)
    @user = User.find(activity.owner_id)
  	json.deal do
      json.id @deal.id
      json.name @deal.name
      json.description @deal.description
      json.url @deal.image_url
    end
    json.commenter do
      json.id @user.id
      json.name @user.name 
    end
    json.comment do
      json.id @comment.id
      json.content @comment.content
    end
  end
end