# == Define: cups::configure::printer::default
#
# Configure cups to use named printer and set it as default.
#
# === Parameters
#
# [*printer_name*]
#   If not explicitly set, will default to resource name.
#   Name of printer to configure as default.
#
# === Examples
#
#   cups::configure::printer::default {'wh8e_dell5110': }
#   cups::configure::printer::default {'adding default printer': printer_name => 'wh8e_dell5110_d' }
#
# === Authors
#
# Author <author@domain.tld>
#
# === Copyright
#
# No copyright expressed, or implied.
#
define cups::configure::printer::default($printer_name = '') {

  # set printer name using resource name, if not provided
  if ! $printer_name {
    $real_printer_name = $name
  } else {
    $real_printer_name = $printer_name
  }

  cups::configure::printer {$real_printer_name: }

  # set to default printer with lpstat
  exec {"set ${real_printer_name} to default using lpoptions":
    command  => "lpoptions -d ${real_printer_name}",
    unless   => "lpstat -d | grep ${real_printer_name} 2>/dev/null >/dev/null",
    require  => Cups::Configure::Printer[$name]
  }

}