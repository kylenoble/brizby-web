class Api::V1::BaseController < Api::BaseController
    before_action :set_resource, only: [:destroy, :show, :update]

    # POST /api/{plural_resource_name}
    def create
      @resource = set_resource(resource_class.new(resource_params))

      if get_resource.save
        if params.has_key?(:deal)
          add_activity(resource_class, params.fetch(:deal)[:business_id], "business")
        elsif params.has_key?(:post)
          add_activity(resource_class, params.fetch(:post)[:postable_id], params.fetch(:post)[:postable_type])
        end
        
        render :show, status: :created
      else
        render json: get_resource.errors, status: :unprocessable_entity
      end
    end

    # DELETE /api/{plural_resource_name}/1
    def destroy
      get_resource.destroy
      head :no_content
    end

    # GET /api/{plural_resource_name}
    def index
      plural_resource_name = "@#{resource_name.pluralize}"
      resources = resource_class.where(query_params)
                                .order(order_params[:order])
                                .page(page_params[:page])
                                .per(page_params[:page_size])
                  
      instance_variable_set(plural_resource_name, resources)
      respond_with instance_variable_get(plural_resource_name)
    end

    # GET /api/{plural_resource_name}/1
    def show
      respond_with get_resource
    end

    # PATCH/PUT /api/{plural_resource_name}/1
    def update
      if get_resource.update(resource_params)
        render :show
      else
        render json: get_resource.errors, status: :unprocessable_entity
      end
    end

    private

      def json_request?
        request.format.json?
      end

      def add_activity(class_name, user, type)
        if type == "business"
          @business = Business.find(user)
        else
          @user = User.find(user)
        end

        if class_name == Deal
          @deal = get_resource
          @deal.delay.create_activity :create, owner: @business, latitude: @business.latitude, longitude: @business.longitude, category: @business.category
        elsif class_name == Post
          @post = get_resource
          if @post.postable_type == "business"
            @post.delay.create_activity :create, owner: @business, latitude: @business.latitude, longitude: @business.longitude, category: @business.category
          else
            @post.delay.create_activity :create, owner: @user, latitude: params.fetch(:post)[:latitude], longitude: params.fetch(:post)[:longitude]
          end
        else
          puts "no activity"
        end
      end

      # Returns the resource from the created instance variable
      # @return [Object]
      def get_resource
        instance_variable_get("@#{resource_name}")
      end

      # Returns the allowed parameters for searching
      # Override this method in each API controller
      # to permit additional parameters to search on
      # @return [Hash]
      def query_params
        {}
      end

      # Returns the allowed parameters for order
      # Override this method in each API controller
      # to permit additional parameters to search on
      # @return [Hash]
      def order_params
        params.permit(:order)
      end

      # Returns the allowed parameters for pagination
      # @return [Hash]
      def page_params
        params.permit(:page, :page_size)
      end

      # The resource class based on the controller
      # @return [Class]
      def resource_class
        @resource_class ||= resource_name.classify.constantize
      end

      # The singular name for the resource class based on the controller
      # @return [String]
      def resource_name
        @resource_name ||= self.controller_name.singularize
      end

      # Only allow a trusted parameter "white list" through.
      # If a single resource is loaded for #create or #update,
      # then the controller for the resource must implement
      # the method "#{resource_name}_params" to limit permitted
      # parameters for the individual model.
      def resource_params
        @resource_params ||= self.send("#{resource_name}_params")
      end

      # Use callbacks to share common setup or constraints between actions.
      def set_resource(resource = nil)
        resource ||= resource_class.find(params[:id])
        instance_variable_set("@#{resource_name}", resource)
      end
end