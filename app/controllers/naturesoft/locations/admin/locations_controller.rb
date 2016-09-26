require_dependency "naturesoft/application_controller"

module Naturesoft
  module Locations
    module Admin
      class LocationsController < Naturesoft::Admin::AdminController
        before_action :set_location, only: [:show, :edit, :update, :destroy, :enable, :disable]
        before_action :default_breadcrumb
        
        # add top breadcrumb
        def default_breadcrumb
          add_breadcrumb "Location", naturesoft_locations.admin_locations_path
        end
    
        # GET /locations
        def index
          @locations = Location.search(params).paginate(:page => params[:page], :per_page => 10)
        end
    
        # GET /locations/1
        def show
        end
    
        # GET /locations/new
        def new
          @location = Location.new
          add_breadcrumb "New Location", nil,  class: "active"
        end
    
        # GET /locations/1/edit
        def edit
          add_breadcrumb "Edit Location", nil,  class: "active"
        end
    
        # POST /locations
        def create
          @location = Location.new(location_params)
          @location.user = current_user
    
          if @location.save
            redirect_to naturesoft_locations.edit_admin_location_path(@location.id), notice: 'Location was successfully created.'
          else
            render :new
          end
        end
    
        # PATCH/PUT /locations/1
        def update
          if @location.update(location_params)
            redirect_to naturesoft_locations.edit_admin_location_path(@location.id), notice: 'Location was successfully updated.'
          else
            render :edit
          end
        end
    
        # DELETE /locations/1
        def destroy
          @location.destroy
          render text: 'Location was successfully destroyed.'
        end
        
        #CHANGE STATUS /locations
        def enable
          @location.enable
          render text: 'Location was successfully active.'
        end
        
        def disable
          @location.disable
          render text: 'Location was successfully inactive.'
        end
        
        # DELETE /locations/delete?ids=1,2,3
        def delete
          @locations = Location.where(id: params[:ids].split(","))
          @locations.destroy_all
          render text: 'Location(s) was successfully destroyed.'
        end
    
        private
          # Use callbacks to share common setup or constraints between actions.
          def set_location
            @location = Location.find(params[:id])
          end
    
          # Only allow a trusted parameter "white list" through.
          def location_params
            params.fetch(:location, {}).permit(:name, :longitude, :latitude, :area_id)
          end
      end
    end
  end
end
