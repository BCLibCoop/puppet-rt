# This manifest contains customization for BC Library Coop 
# RT 3.8 deployment
#

class rt::bclc_custom (
    $ensure = 'present'
     ) {
   file { '/etc/request-tracker3.8/RT_SiteConfig.d/':
     ensure => directory,
     mode   => '0755',
     owner  => 'root',
     group  => 'root',
  }

   # Suppress all outgoing emails
   #
   file { '/etc/request-tracker3.8/RT_SiteConfig.d/60-mail-suppress':
    ensure  => 'present',
    source  => 'puppet:///modules/rt/etc/request-tracker3.8/RT_SiteConfig.d/60-mail-suppress',
    mode    => '0600',
    owner   => 'root',
    group   => 'root',
    require => File['/etc/request-tracker3.8/RT_SiteConfig.d/'],
  }

   file { '/usr/share/request-tracker3.8/lib/RT/Action/SendEmail.pm':
    ensure  => 'file',
    source  => 'puppet:///modules/rt/usr/share/request-tracker3.8/lib/RT/Action/SendEmail.pm',
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
  }

   # Mapping between priority strings and the internal
   # numeric representation
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
