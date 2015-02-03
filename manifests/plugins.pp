# Class: rt::plugins
# TODO:
# - Fix config path to file
#   Ubuntu/Debian have per-plugin config files (also need to fix the notifies)
#   Redhat has it all it one file, this needs to be made extensible
# - Take a better data structure for the configuration input or priorities/order
#
class rt::plugins (
    $ensure = 'present',
    $config_file = "${rt::params::rt_dir}/RT_SiteConfig.d/55-plugins"
) inherits ::rt::params {

  file { $config_file:
    ensure  => $ensure,
    mode    => '0600',
    owner   => 'root',
    group   => 'root',
    require => File['/etc/request-tracker3.8/RT_SiteConfig.d/'],
    #notify  => Exec['update-rt-siteconfig'],
  }

  file_line { 'InitPluginList':
    ensure => $ensure,
    path   => $config_file,
#    match  => '^Set..PriorityAsString,',
    line   => "Set(@Plugins, qw());",
    #notify => Exec['update-rt-siteconfig'],
  }


  file_line { 'RTFMPlugin':
    ensure => $ensure,
    path   => $config_file,
#    match  => '^Set..PriorityAsString,',
    line   => "Set(@Plugins, push('RT::FM'));",
    #notify => Exec['update-rt-siteconfig'],
  }

  file_line { 'PriorityAsStringPlugin':
    ensure => $ensure,
    path   => $config_file,
#    match  => '^Set..PriorityAsStringOrder,',
    line   => "Set(@Plugins, push('RT::Extension::PriorityAsString'));",
    #notify => Exec['update-rt-siteconfig'],
  }
}
# vim: set ft=puppet si sts=2 et tw=80 sw=2:
