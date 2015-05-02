# == Class: cups
#
# Install cups package and ensure service running.
#
# === Parameters
#
# None
#
# === Variables
#
# None
#
# === Examples
#
#  class { 'cups': }
#
#  include cups
#
# === Authors
#
# Author <author@domain.tld>
#
# === Copyright
#
# No copyright expressed, or implied.
#
class cups {

  # install cups package
  package { 'cups': ensure => 'installed' }

  # run cups
  service { 'cups':
    ensure     => 'running',
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    require    => Package['cups'],
  }

}
