# Common hosts configuration: repository, misc. software, php

node 'common' {
  # Init apt
  class { "apt": }
  
  # Add DotDeb Repo
  apt::key { "dotdeb":
    key        => '89DF5277',
    key_source => 'http://www.dotdeb.org/dotdeb.gpg',
  }
  
  apt::source { 'dotdeb':
    location   => 'http://packages.dotdeb.org',
    release    => 'wheezy',
    repos      => 'all',
    key        => '89DF5277',
    key_source => 'http://www.dotdeb.org/dotdeb.gpg',
    include_src => false,
  }
  
  apt::source { 'dotdeb-php55':
    location   => 'http://packages.dotdeb.org',
    release    => 'wheezy-php55',
    repos      => 'all',
    key        => '89DF5277',
    key_source => 'http://www.dotdeb.org/dotdeb.gpg',
    include_src => false,
  }
  
  # usefull tools
  package { ["screen", "tmux", "vim", "bash-completion", "curl", "wget"] :
    ensure  => latest,
    require => Class['apt::update'],
  }
}

# Gearman Client Configuration
node 'gclient' inherits 'common' {
  # Add queue host and ip to hosts file
  host { 'gqueue':
	  ensure => present,
	  ip   => '192.168.67.21',
  }

  # php
  package { ['php5-common', 'php5-cli', 'php5-dev', 'php5-gd', 'php5-intl', 'php5-gearman', ] :
    ensure => latest,
    require => Class['apt::update'],
  }

  # Add phpclient group
  group { "phpclient":
    name   => "phpclient",
    ensure => "present",
  }

  # Add phpclient user with password phpclient
  user { "phpclient":
    name       => "phpclient",
    password   => '$6$3t6mSvpTmd0MQ2h$v9Ye7v93LOivnQIgTf73nIoCnU/YdyDtqrRzL/9KbAF2f1VuAapOsRNHj0cDGyIuHz2hB0PYR/B1aonX4zamX0',
    groups     => ["phpclient"],
    comment    => "PHP Client User",
    ensure     => "present",
    home       => "/home/phpclient",
    managehome => true,
    shell      => "/bin/bash",
    require    => [Group["phpclient"], ],
  }
}

# Gearman Job Server (Queue) configuration, Gearman Job Server is installed on this machine
node 'gqueue' inherits 'common' {
  # Add client host and ip to hosts file
  host { 'gclient':
    ensure => present,
    ip   => '192.168.67.20',
  }

  # Add worker host and ip to hosts file
  host { 'gworker1':
    ensure => present,
    ip   => '192.168.67.22',
  }

  # Add worker host and ip to hosts file
  host { 'gworker2':
    ensure => present,
    ip   => '192.168.67.23',
  }

  class { 'gearman': }
}

# Common Gearman Workers configuration
node 'gwcommon' inherits 'common' {
  # Add queue host and ip to hosts file
  host { 'gqueue':
    ensure => present,
    ip   => '192.168.67.21',
  }

  # php
  package { ['php5-common', 'php5-cli', 'php5-dev', 'php5-gd', 'php5-intl', 'php5-gearman', ] :
    ensure => latest,
    require => Class['apt::update'],
  }

  # Add phpworker group
  group { "phpworker":
    name   => "phpworker",
    ensure => "present",
  }

  # Add phpworker user with password phpworker
  user { "phpworker":
    name       => "phpworker",
    password   => '$6$.VKCLpy.xIQL8U$KzNLp1MJrfnG42CfQ96.6PjLMtg.vh.YaesG3QGdPtuNVENXP2XB.6szhO6u3XxpHZM8X98gzIZAZSJd94Whe/',
    groups     => ["phpworker"],
    comment    => "PHP Worker User",
    ensure     => "present",
    home       => "/home/phpworker",
    managehome => true,
    shell      => "/bin/bash",
    require    => [Group["phpworker"], ],
  }
}

# Worker 1
node 'gworker1' inherits 'gwcommon' {
  # Add worker host and ip to hosts file
  host { 'gworker2':
	  ensure => present,
	  ip   => '192.168.67.23',
  }
}

# Worker 2
node 'gworker2' inherits 'gwcommon' {
  # Add worker host and ip to hosts file
  host { 'gworker1':
	  ensure => present,
	  ip   => '192.168.67.22',
  }
}
