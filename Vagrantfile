# frozen_string_literal: true
# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = 'ubuntu/trusty64'
  config.vm.provision :shell, path: 'bootstrap.sh', keep_color: true
  config.vm.provision :shell, path: 'install-rvm.sh', args: 'stable', privileged: false
  config.vm.provision :shell, path: 'install-ruby.sh', args: '2.3.0', privileged: false
  config.vm.provision :shell, path: 'install-libdogma.sh',
      env: {
          LIBDOGMA_URL: 'https://github.com/osmium-org/libdogma/releases/download/v1.2.0-cit10/libdogma-1.2.0-cit10.tar.xz'
      }
end
