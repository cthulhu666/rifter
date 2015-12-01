module Rifter
module Traits
  class XelakVydupDyzutDuzytNukekLemopLiranSisapVytepFutykMedisSigekHefahNemarSygafVorerZaxyx < Trait

    description "bonus to Missile velocity"

    def effect(fitting:, skill_lvl:)
      fitting.boost_module_attribute(
        -> (m) { m.item.skill_required?('Missile Launcher Operation') },
        :max_velocity,
        skill_lvl * bonus
      )
    end

  end
end

end