Naturesoft::Locations::Engine.routes.draw do
  namespace :backend, module: "backend", path: "backend/locations" do
    resources :locations do
      collection do
        put "enable"
        put "disable"
        delete "delete"
      end
    end
  end
end