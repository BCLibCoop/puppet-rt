#
class rt::prioasstring (
    $ensure = 'present'
     ) {
    #

   file { '/etc/request-tracker3.8/RT_SiteConfig.d/70-prioasstring':
    ensure  => 'present',
    source  => 'puppet:///modules/rt/etc/request-tracker3.8/RT_SiteConfig.d/70-prioasstring',
    mode    => '0600',
    owner   => 'root',
    group   => 'root',
    require => File['/etc/request-tracker3.8/RT_SiteConfig.d/'],
  }
}
