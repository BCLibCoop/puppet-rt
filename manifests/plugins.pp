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

  concat { $config_file:
    ensure  => $ensure,
    mode    => '0600',
    owner   => 'root',
    group   => 'root',
    replace => true,
    require => File['/etc/request-tracker4/RT_SiteConfig.d/'],
    #notify  => Exec['update-rt-siteconfig'],
  }

  concat::fragment { 'InitPluginList':
    target  => $config_file,
    content => "my @_plugins;\n",
    order   => '01',
    #notify => Exec['update-rt-siteconfig'],
  }

  concat::fragment { 'PriorityAsStringPlugin':
    target => $config_file,
    content => "push(@_plugins, 'RT::Extension::PriorityAsString');\n",
    order   => '03',
    #notify => Exec['update-rt-siteconfig'],
  }

  concat::fragment { 'ClosePluginList':
    target => $config_file,
    content => "Set(@Plugins, @_plugins);\n",
    order   => '04',
    #notify => Exec['update-rt-siteconfig'],
  }

  concat::fragment { 'TicketLifecycles':
    target => $config_file,
    content => "Set(@Lifecycles, qw(resolved didntfix noresponse rejected deleted featurereq));\n",
    order   => '05',
    #notify => Exec['update-rt-siteconfig'],
  }

}
# vim: set ft=puppet si sts=2 et tw=80 sw=2:
