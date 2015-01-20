#
class rt::mailsuppress (
    $ensure = 'present'
     ) {
    #
   file { '/etc/request-tracker3.8/RT_SiteConfig.d/60-mail-suppress':
    ensure  => 'file',
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
}
