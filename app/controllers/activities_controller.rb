class ActivitiesController < ApplicationController
  def index
    @activities = PublicActivity::Activity.order(&quot;created_at desc&quot;)
  end
end
