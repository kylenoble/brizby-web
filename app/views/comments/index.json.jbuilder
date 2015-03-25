json.comments @comments.each do |comment|
	json.id = comment.id
	if comment.userable_type == "user"
		@user = User.find(comment.userable_id)
    json.user do
      json.cache! @user do 
        json.partial! @user
      end
    end
	 else
	 		@business = Business.find(comment.userable_id)
	    json.business do
	      json.cache! @business do 
	        json.partial! @business
	      end
	    end
	  end
	end 

