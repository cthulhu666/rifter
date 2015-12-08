require 'rifter'
include Rifter

ENV['MONGODB_HOST'] ||= "localhost:#{`docker port rifter_mongodb_1 27017/tcp | grep -Eo '([0-9]{5})$'`}".strip
Mongoid.load!('mongoid.yml', :test)
