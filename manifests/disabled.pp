# == Class: cups::disabled
#
# Make sure cups is not running
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
#  class { 'cups::disabled': }
#
#  include cups::disabled
#
# === Authors
#
# Author <author@domain.tld>
#
# === Copyright
#
# No copyright expressed, or implied.
#
class cups::disabled inherits cups {

  # stop cups
  Service['cups']{
    ensure => 'stopped',
    enable => false,
  }

}
