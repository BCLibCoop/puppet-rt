#
class rt::mailsuppress (
    $ensure = 'present'
     ) {
    #
   file { '/etc/request-tracker4/RT_SiteConfig.d/':
     ensure => directory,
     mode   => '0755',
     owner  => 'root',
     group  => 'root',
  }

   file { '/etc/request-tracker4/RT_SiteConfig.d/60-mail-suppress':
    ensure  => 'present',
    source  => 'puppet:///modules/rt/etc/request-tracker4/RT_SiteConfig.d/60-mail-suppress',
    mode    => '0600',
    owner   => 'root',
    group   => 'root',
    require => File['/etc/request-tracker4/RT_SiteConfig.d/'],
  }

   file { '/usr/share/request-tracker4/lib/RT/Action/SendEmail.pm':
    ensure  => 'file',
    source  => 'puppet:///modules/rt/usr/share/request-tracker4/lib/RT/Action/SendEmail.pm',
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
  }

}
