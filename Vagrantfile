# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "wheezy64"
  
  config.vm.define "gclient" do |gclient|
	gclient.vm.network :private_network, ip: "192.168.67.20"
	gclient.vm.hostname = "gclient"
	gclient.vm.synced_folder "phpclient/", "/home/phpclient", create: true

	gclient.vm.provider "virtualbox" do |vb|
	  vb.name = "gclient"
      vb.customize ["modifyvm", :id, "--memory", "512"]
      vb.customize ["modifyvm", :id, "--cpuexecutioncap", "50"]
    end
  end

  config.vm.define "gqueue" do |gqueue|
  	gqueue.vm.network :private_network, ip: "192.168.67.21"
  	gqueue.vm.hostname = "gqueue"

  	gqueue.vm.provider "virtualbox" do |vb|
  	  vb.name = "gqueue"
        vb.customize ["modifyvm", :id, "--memory", "512"]
        vb.customize ["modifyvm", :id, "--cpuexecutioncap", "50"]
      end
    end

  config.vm.define "gworker1" do |gworker|
	gworker.vm.network :private_network, ip: "192.168.67.22"
	gworker.vm.hostname = "gworker1"
	gworker.vm.synced_folder "phpworker/", "/home/phpworker", create: true

	gworker.vm.provider "virtualbox" do |vb|
	  vb.name = "gworker1"
      vb.customize ["modifyvm", :id, "--memory", "512"]
      vb.customize ["modifyvm", :id, "--cpuexecutioncap", "50"]
    end
  end
  
  config.vm.define "gworker2" do |gworker|
	gworker.vm.network :private_network, ip: "192.168.67.23"
	gworker.vm.hostname = "gworker2"
	gworker.vm.synced_folder "phpworker/", "/home/phpworker", create: true

	gworker.vm.provider "virtualbox" do |vb|
	  vb.name = "gworker2"
      vb.customize ["modifyvm", :id, "--memory", "512"]
      vb.customize ["modifyvm", :id, "--cpuexecutioncap", "50"]
    end
  end
  
  config.vm.provision "puppet" do |puppet|
    puppet.manifests_path = "puppet/manifests"
    puppet.manifest_file  = "site.pp"
	puppet.module_path    = "puppet/modules"
    puppet.options = "--verbose --debug"
  end
  
end
