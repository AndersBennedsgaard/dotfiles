# The "2" in Vagrant.configure configures the configuration version
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  config.vm.box = "generic/ubuntu2204"

  # Disable automatic box update checking
  # config.vm.box_check_update = false

  # Create a forwarded port mapping from a port on the host to the VM
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a private network
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder
  # config.vm.synced_folder "../data", "/vagrant_data"

  config.vm.provider "virtualbox" do |vb|
    # Display the VirtualBox GUI when booting the machine
    vb.gui = true
  
    # Customize the amount of memory on the VM:
    # vb.memory = "1024"
  end

  # set danish keyboard layout
  config.vm.provision "shell",
    inline: 'sed -i \'s/XKBLAYOUT="\w*"/XKBLAYOUT="dk"/\' /etc/default/keyboard'

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "main.yaml"
    ansible.ask_become_pass = true
    ansible.compatibility_mode = "2.0"
  end
end
