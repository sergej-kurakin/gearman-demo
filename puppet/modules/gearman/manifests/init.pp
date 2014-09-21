class gearman {

  package { 'gearman-job-server' :
    ensure => latest,
    require => Class['apt::update'],
  }

  file { 'gearman-job-server':
    path    => '/etc/default/gearman-job-server',
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Package['gearman-job-server'],
    notify  => Service['gearman-job-server'],
    source  => "puppet:///modules/gearman/gearman-job-server"
  }

  service { 'gearman-job-server':
    ensure     => running,
    hasstatus  => true,
    hasrestart => true,
    enable     => true,
    require    => [Package['gearman-job-server'], File['gearman-job-server']],
  }

}