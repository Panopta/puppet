##2017-07-25 - Release 1.0.2
#### Minor bugfixes & improvements

Fix: server_group is no longer required.
Fix: apt_get update is no longer called twice.
Fix: server_group is an int, was used as string in template.
Fix: manifest file doesn't get replaced when it already exists

##2017-07-23 - Release 1.0.1
Update: Changelog for release 1.0.0

##2017-07-23 - Release 1.0.0
Major update after a long time.
 - Redone most of the module
 - Removed old force install
 - Added normal puppetlabs/apt usage for adding the panopta repository
 - Renamed modules to plugins as this is the official naming
 - Updated tests for my test environment
 - Removed puppetlabs/concat dependency
 - Fixed how plugins being handled in manifest

##2014-10-24 - Release 0.0.3
###Summary

Minor bug fixe

####Bugfixes
- Permanent fix for the error "E: There are problems and -y was used without --force-yes"
  This added option 'forceInstall => true/false' to allow the forced install or not.

##2014-10-20 - Release 0.0.2

###Summary

Minor bug fixes + Updates.

####Bugfixes
- Sometimes the panopta-agent package doesn't get installed. Shomehow changing the install_options from array to string solved the issue.
- Added a changelog.
- Updated the Readme.

##2014-10-20 - Release 0.0.1

###Summary
This is the first release.
