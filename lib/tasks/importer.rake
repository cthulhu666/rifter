require 'rifter'
require 'rifter/importer'

include Rifter

namespace :importer do
  task :run do
    if defined?(Rails)
      Rake::Task['environment'].invoke
    else
      Mongoid.load!('mongoid.yml')
    end

    Importer.new.import
    ShipModule.setup_ship_modules
    Charge.bind_to_launchers
    Ship::Trait.setup
    Drone.assign_required_skills
    Drone.classify_drones
  end
end
