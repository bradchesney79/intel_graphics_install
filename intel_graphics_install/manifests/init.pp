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
class intel_graphics_install ($os = undef, $osVersion = undef, $architecture = undef) {

  define append_line_if_not_found ($line = undef, $sources = undef, $refreshonly = false) {
    exec { "/bin/echo '$line' >> '$sources'":
      unless      => "/bin/grep -Fxqe '$line' '$sources'",
      refreshonly => $refreshonly,
    }
  }

  if $::operatingsystem == 'ubuntu' or 'kubuntu' or 'lubuntu' {
    # do something *buntu specific
    $os = $::operatingsystem
    $sources = '/etc/apt/sources.list'
    /*
    * check /etc/apt/trusted.gpg for repository gpg key
    * http://ubuntuforums.org/showthread.php?t=1257504
    */ 
    exec { "wget --no-check-certificate https://download.01.org/gfx/RPM-GPG-KEY-ilg -O - | sudo apt-key add -":
      onlyif => "sudo apt-key --keyring /etc/apt/trusted.gpg list|grep -c 2048R/75E52366",
      refreshonly => true,
    }

    exec { "wget --no-check-certificate https://download.01.org/gfx/RPM-GPG-KEY-ilg-2 -O - | sudo apt-key add -":
      onlyif => "sudo apt-key --keyring /etc/apt/trusted.gpg list|grep -c 4096R/2F4AAA66",
      refreshonly => true,
    }
    
    if $::architecture == 'amd64' or 'i386' {
        $architecture = $::architecture
    }
    
    if $::operatingsystemrelease == '12.04' {
      $osVersion = $::operatingsystemrelease
      append_line_if_not_found { sources:
        line => 'deb https://download.01.org/gfx/ubuntu/12.04/main Ubuntu 12.04',
        sources => $sources
      }
    }
    
    if $::operatingsystemrelease == '12.10' {
      $osVersion = $::operatingsystemrelease
      append_line_if_not_found { sources:
        line => 'deb https://download.01.org/gfx/ubuntu/12.10/main Ubuntu 12.10',
        sources => $sources
      }
    }
    
    if $::operatingsystemrelease == '13.04' {
      $osVersion = $::operatingsystemrelease
      append_line_if_not_found { sources:
        line => 'deb https://download.01.org/gfx/ubuntu/13.04/main Ubuntu 13.04',
        sources => $sources
      }
    }
    
    if $::operatingsystemrelease == '13.10' {
      $osVersion = $::operatingsystemrelease
      append_line_if_not_found { sources:
        line => 'deb https://download.01.org/gfx/ubuntu/13.10/main Ubuntu 13.10',
        sources => $sources
      }
    }
    
    
    if $::operatingsystemrelease == '14.04' {
      $osVersion = $::operatingsystemrelease
      append_line_if_not_found { sources:
        line => 'deb https://download.01.org/gfx/ubuntu/14.04/main Ubuntu 14.04',
        sources => $sources
      }
    }
    
    if $::operatingsystemrelease == '14.10' {
      $osVersion = $::operatingsystemrelease
      append_line_if_not_found { sources:
        line => 'deb https://download.01.org/gfx/ubuntu/14.10/main Ubuntu 14.10',
        sources => $sources
      }
    }
  }

  /*
   * if $::operatingsystem == 'fedora' {
   * # do something Fedora specific
   * $os = $::operatingsystem
   *
   *}
   */

  if $os != undef and $osVersion != undef and $architecture != undef {

  }
    

}
