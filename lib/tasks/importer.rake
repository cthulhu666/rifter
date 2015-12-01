include Rifter
require 'rifter/importer'

namespace :importer do
  task :run do
    Mongoid.load!('mongoid.yml')
    Importer.new.import
    ShipModule.setup_ship_modules
    Charge.bind_to_launchers
    Ship::Trait.setup
    Drone.assign_required_skills
    Drone.classify_drones
  end
end
