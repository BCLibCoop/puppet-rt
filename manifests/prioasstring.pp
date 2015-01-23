# Class: rt::prioasstring
# TODO:
# - Fix config path to file
#   Ubuntu/Debian have per-plugin config files (also need to fix the notifies)
#   Redhat has it all it one file, this needs to be made extensible
# - Take a better data structure for the configuration input or priorities/order
class rt::prioasstring (
    $ensure = 'present',
    $priorities = '(None => 0, Low => 10, Medium => 50, High => 70, Urgent => 90)',
    $order = 'qw(None Low Medium High Urgent)',
    $config_file = "${rt::params::rt_dir}/RT_SiteConfig.d/70-prioasstring"
) {

  file { $config_file:
    ensure  => $ensure,
    mode    => '0600',
    owner   => 'root',
    group   => 'root',
    require => File['/etc/request-tracker3.8/RT_SiteConfig.d/'],
    #notify  => Exec['update-rt-siteconfig'],
  }

  file_line { 'PriorityAsString':
    ensure => $ensure,
    path   => $config_file,
    match  => '^Set..PriorityAsString,',
    line   => "Set(%PriorityAsString, ${priorities});",
    #notify => Exec['update-rt-siteconfig'],
  }

  file_line { 'PriorityAsStringOrder':
    ensure => $ensure,
    path   => $config_file,
    match  => '^Set..PriorityAsStringOrder,',
    line   => "Set(@PriorityAsStringOrder, ${order});",
    #notify => Exec['update-rt-siteconfig'],
  }
}
# vim: set ft=puppet si sts=2 et tw=80 sw=2:
