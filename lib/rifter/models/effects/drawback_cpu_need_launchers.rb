module Rifter
module Effects
  class DrawbackCPUNeedLaunchers < Effect

    def effect(attrs, fitting:, fitted_module:)
      fitting.launchers.each do |launcher|
        launcher.boost_attribute(:cpu_usage, fitted_module.drawback)
      end
    end


  end
end

end