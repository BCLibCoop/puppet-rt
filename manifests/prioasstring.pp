# Class: rt::prioasstring
# TODO:
# - Fix config path to file
#   Ubuntu/Debian have per-plugin config files (also need to fix the notifies)
#   Redhat has it all it one file, this needs to be made extensible
# - Take a better data structure for the configuration input or priorities/order
#
class rt::prioasstring (
    $ensure = 'present',
    $priorities = '(None => 0, Low => 10, Medium => 50, High => 70, Urgent => 90)',
    $order = 'qw(None Low Medium High Urgent)',
    $config_file = "${rt::params::rt_dir}/RT_SiteConfig.d/70-prioasstring"
) inherits ::rt::params {

  concat { $config_file:
    ensure  => $ensure,
    mode    => '0600',
    owner   => 'root',
    group   => 'root',
    require => File['/etc/request-tracker4/RT_SiteConfig.d/'],
    #notify  => Exec['update-rt-siteconfig'],
  }

  concat::fragment { "${config_file}_prioasstring":
    target  => $config_file,
    content => "Set(%PriorityAsString, ${priorities});\n",
    #notify => Exec['update-rt-siteconfig'],
  }

  concat::fragment { "${config_file}_prioasstringorder":
    target  => $config_file,
    content => "Set(@PriorityAsStringOrder, ${order});\n",
    #notify => Exec['update-rt-siteconfig'],
  }
}
# vim: set ft=puppet si sts=2 et tw=80 sw=2:
