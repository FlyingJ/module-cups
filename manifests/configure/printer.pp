# == Define: cups::configure::printer
#
# Configure cups to use named printer.
#
# === Parameters
#
# [*printer_name*]
#   If not explicitly set, will default to resource name.
#   Name of printer to configure.
#
# === Examples
#
#   cups::configure::printer {'wh8e_dell5110': }
#   cups::configure::printer {'adding some printer': printer_name => 'wh8e_dell5110_d' }
#
# === Authors
#
# Author <author@domain.tld>
#
# === Copyright
#
# No copyright expressed, or implied.
#
define cups::configure::printer($printer_name = '') {

  # cups should be available
  include cups

  # set printer name using resource name, if not provided
  if ! $printer_name {
    $real_printer_name = $name
  } else {
    $real_printer_name = $printer_name
  }

  # copy in appropriate PPD file
  file {"/etc/cups/ppd/${real_printer_name}.ppd":
    ensure => 'file',
    source => "puppet:///modules/cups/etc/cups/ppd/${real_printer_name}.ppd",
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }

  # add the printer
  exec {"add ${real_printer_name} using lpadmin":
    command => "lpadmin -p ${real_printer_name} -E -D \"${real_printer_name}\" -L \"https://printserver.domain.tld:631/printers/${real_printer_name}\" -v \"ipp://printserver.domain.tld:631/printers/${real_printer_name}\" -P /etc/cups/ppd/${real_printer_name}.ppd",
    unless  => "lpstat -p ${real_printer_name} 2>/dev/null >/dev/null",
    require => File["/etc/cups/ppd/${real_printer_name}.ppd"],
  }

}
