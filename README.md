= Gearman Demo

This is a a Gearman Demo setup using Vagrant, Debian Wheezy (custom box) and PHP.

 Setup instructions:

* Install VirtualBox from https://www.virtualbox.org/
* Install Vagrant from https://www.vagrantup.com/
* Add any Debian Wheezy box from https://vagrantcloud.com/ (with Puppet support)
* Clone the repo `git clone https://github.com/sergej-kurakin/gearman-demo.git`
* Init sub-modules `git submodule init`
* Update sub-modules `git submodule update`
* Run `vagrant up` to start environment

Connect using SSH to servers `gworker1` and `gworker2` (login: phpworker, password: phpworker) and start workers from command line: `php -f ~/worker.php`

Connect using SSH to server `gclient` (login: phpclient, password: phpclient) and send command to job queue: `php -f ~/client.php`
