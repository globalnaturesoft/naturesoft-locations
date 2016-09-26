module Naturesoft::Locations
  class Location < ApplicationRecord
    belongs_to :user
    belongs_to :area, class_name: "Naturesoft::Areas::Area"
    
    validates :name, :longitude, :latitude, presence: true
    
    def self.sort_by
      [
        ["Name","naturesoft_locations_locations.name"],
        ["Created At","naturesoft_locations_locations.created_at"]
      ]
    end
    def self.sort_orders
      [
        ["ASC","asc"],
        ["DESC","desc"]
      ]
    end
    
    #Filter, Sort
    def self.search(params)
      records = self.all
      
      if params[:scale].present?
        records = records.where(image_scale: params[:scale])
      end
      
      #Search keyword filter
      if params[:keyword].present?
        params[:keyword].split(" ").each do |k|
          records = records.where("LOWER(CONCAT(naturesoft_locations_locations.name,' ',naturesoft_locations_locations.longitude,' ',naturesoft_locations_locations.latitude)) LIKE ?", "%#{k.strip.downcase}%") if k.strip.present?
        end
      end
      
      # for sorting
      sort_by = params[:sort_by].present? ? params[:sort_by] : "naturesoft_locations_locations.name"
      sort_orders = params[:sort_orders].present? ? params[:sort_orders] : "asc"
      records = records.order("#{sort_by} #{sort_orders}")
      
      return records
    end
    
    # enable/disable status
    def enable
			update_columns(status: "active")
		end
    
    def disable
			update_columns(status: "inactive")
		end
    
  end
end
