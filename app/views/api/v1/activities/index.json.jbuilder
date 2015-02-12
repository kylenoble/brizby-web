json.feed @activities do |activity|
  json.activity_type activity.key
  json.time activity.created_at
  if activity.trackable_type == 'Deal'
    @deal = Deal.find(activity.trackable_id)
    @business = Business.find(activity.owner_id)
    json.namestuff "The name"
    json.pics do 
      @deal.images.each do |image|
        json.status "images"
        json.image image.image.url(:med)
      end
    end
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
  elsif activity.trackable_type == 'Post'
    @post = Post.find(activity.trackable_id)
    @business = Business.find(activity.owner_id)
    json.post do
      json.cache! @post do
        json.partial! @post
      end
    end 
    json.business do
      json.cache! @business do 
        json.partial! @business
      end
    end
  elsif activity.trackable_type == 'Followship'
    json.follower do
      @user = User.find(activity.owner_id)
      json.cache! @user do
        json.partial! @user
      end
    end 

    if activity.recipient_type == "Business"
      @business = Business.find(activity.recipient_id)
      json.followee do
        json.cache! @business do
          json.partial! @business
        end
      end 
    else
      @user = User.find(activity.recipient_id)
      json.followee do
        json.cache! @user do
          json.partial! @user
        end
      end
    end 
  else
    @deal = Deal.find(activity.recipient_id)
    @post = Post.find(activity.recipient_id)
    @comment =  Comment.find(activity.trackable_id)
    @user = User.find(activity.owner_id)
    @business = Business.find(activity.owner_id)
  	if activity.trackable_type == "Deal"
      json.deal do
        json.cache! @deal do
          json.partial! @deal
        end
      end
    else
      json.post do
        json.cache! @post do
          json.partial! @post
        end
      end 
    end

    if activity.owner_type == "User"
      json.commenter do
        json.cache! @user do
          json.partial! @user
        end
      end
    else
      json.commenter do
        json.cache! @business do
          json.partial! @business
        end
      end
    end
    json.comment do
      json.id @comment.id
      json.content @comment.content
    end
  end
end