Naturesoft::Locations::Engine.routes.draw do
  namespace :admin, module: "admin", path: "admin/locations" do
    resources :locations do
      collection do
        put "enable"
        put "disable"
        delete "delete"
      end
    end
  end
end