# Class: intel_graphics_install
#
# This module manages intel_graphics_install
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#

class intel_graphics_install () {
  
  if $::operatingsystem == 'ubuntu' or 'kubuntu' or 'lubuntu' {
    $lsbdistrelease = $::lsbdistrelease
    if $lsbdistrelease > 12.04 {
	    # do something debian derivatives specific
	    $lsbdistcodename = $::lsbdistcodename
	
	    # including the apt module from the puppetlabs forge
	    include apt
	
	    # add the first key from intel's video drivers repository
	    apt::key { 'intel-graphics-1a':
	      key        => '75E52366',
	      key_source => 'https://download.01.org/gfx/RPM-GPG-KEY-ilg',
	    }
	
	    # add the second key from intel's video drivers repository
	    apt::key { 'intel-graphics-2a':
	      key        => '2F4AAA66',
	      key_source => 'https://download.01.org/gfx/RPM-GPG-KEY-ilg-2',
	    }
	
	    #apt-get update via puppet requires resources not in the default path
	    Exec {
	      path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ],
	    }
	
	    # I want to add the repository to the sources so I can add & update the
	    # package like other normal packages
	    apt::source {'intel-graphics':
	      location => "https://download.01.org/gfx/ubuntu/$lsbdistrelease/main",
	      repos    => 'main',
	      release  => $lsbdistcodename,
	    }

	    # this allows me to install the package using normal conventions
	    package { 'intel-linux-graphics-installer':
	      ensure  => installed,
	      require => Apt::Source['intel-graphics'],
	    }
	  }
	}
  if $::operatingsystem == 'fedora' {

  }
}