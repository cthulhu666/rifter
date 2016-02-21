# Rifter

[![Build Status](https://travis-ci.org/cthulhu666/rifter.svg?branch=master)](https://travis-ci.org/cthulhu666/rifter)

Rifter stands for: "Rifter Is a Fitting Tool, Entirely in Ruby", which is a recursive acronym, how cool is that?
It is an engine for fitting ships in Eve Online game, packaged as a Ruby gem.
Well, it's no longer entirely in Ruby. It uses libdogma (https://github.com/osmium-org/libdogma) under the hood.

## Overview

This gem is extracted from [GenEFT](https://geneft.com) application.

## Acknowledgments

I took some code from [PyFa](https://github.com/DarkFenX/Pyfa) and translated to Ruby
(mostly related to calculation of turrets/missiles damage).
These fragments are marked with links to respective code pieces on PyFa github page.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rifter', github: 'cthulhu666/rifter'
```

And then execute:

    $ bundle

As this gem is pretty much niche, it is not published to RubyGems.

## Usage (WORK IN PROGRESS)

### Console

1. checkout repo
2. download eve database dump from https://www.fuzzwork.co.uk/dump/sqlite-latest.sqlite.bz2 and unzip it
3. run importer: `MONGOID_ENV=development MONGODB_URL=localhost bundle exec rake importer:run`
4. run console: `MONGODB_URL=localhost ./bin/console`

Or, if using [Docker](https://www.docker.com/):

1. Points 1 & 2 same as above
3. build image: `docker-compose build app`
4. start mongo: `docker-compose --x-networking start mongodb`
5. run importer: `docker-compose --x-networking run app rake importer:run MONGOID_ENV=development`
6. run console: `docker-compose --x-networking run app`

Rifter console can serve as a ship/modules brower.
Check which cruisers are fastest:

```ruby
q = Ship.cruisers.order( ['miscellaneous_attributes.max_velocity', :desc] )
q.limit(5).map { |s| [s.name, s.max_velocity] }
```

Test an actual fitting:

```ruby
f = ShipFitting.new(ship: Ship.find_by(name: 'Rifter'), character: Character.perfect_skills_character)
3.times { f.fit_module('150mm Light AutoCannon II').charge = Charge.find_by(name: 'EMP S') }
f.calculate_effects
```

Check how much DPS it does:
```ruby
f.turrets_dps
```

## Development (WORK IN PROGRESS)

1. checkout repo
2. download eve database dump from https://www.fuzzwork.co.uk/dump/sqlite-latest.sqlite.bz2 and unzip it
3. run importer: `MONGOID_ENV=test MONGODB_URL=localhost bundle exec rake importer:run`
4. run specs: `MONGODB_URL=localhost bundle exec rake`
5. ...

Or, if using [Docker](https://www.docker.com/):

1. Points 1 & 2 same as above
3. build image: `docker-compose build app`
4. start mongo: `docker-compose --x-networking start mongodb`
5. run importer: `docker-compose --x-networking run app rake importer:run MONGOID_ENV=test`
6. run specs: `docker-compose --x-networking run app rake`
7. ...

## Word about specs

Specs require a complete database import.
It is unusual, but as this code is so much grown together with data, I consider it a good decision.
I use doubles sparingly and operate on real ships/modules most of the time.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/cthulhu666/rifter.
I welcome all help: bugfixes, implementing new features, just remember to write specs.
If you find this gem useful, please consider becoming a patron of my GenEFT project on [Patreon](https://www.patreon.com/geneft)

## Copyright Notice

EVE Online, the EVE logo, EVE and all associated logos and designs are the intellectual property of CCP hf.
All artwork, screenshots, characters, vehicles, storylines, world facts or other recognizable features
 of the intellectual property relating to these trademarks are likewise the intellectual property of CCP hf.
EVE Online and the EVE logo are the registered trademarks of CCP hf.
All rights are reserved worldwide. All other trademarks are the property of their respective owners.
