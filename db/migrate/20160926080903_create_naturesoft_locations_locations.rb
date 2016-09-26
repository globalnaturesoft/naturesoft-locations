class CreateNaturesoftLocationsLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :naturesoft_locations_locations do |t|
      t.string :name
      t.string :longitude
      t.string :latitude
      t.string :status, default: "active"
      t.references :area, index: true, references: :naturesoft_areas_areas
      t.references :user, index: true, references: :naturesoft_users

      t.timestamps
    end
  end
end
