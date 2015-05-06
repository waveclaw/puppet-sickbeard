#sickbeard

#### Table of Contents

1. [Overview](#overview)
2. [Module Description](#module-description)
3. [Setup](#setup)
    * [What sickbeard affects](#what-sickbeard-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with sickbeard](#beginning-with-sickbeard)
4. [Usage](#usage)
5. [Reference](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development](#development)

## Overview

Install Sick-Beard on SLES 12.

## Module Description

This module installs, configures in a basic way and starts the Sick-Beard service.

## Setup

### What sickbeard affects

Installs an RPM from a 3rd party yum repository.

Uses various interesting services that index Usenet Binaries.

Opens selected ports on the system firewall.

### Setup Requirements 

This module pulls in many packages that may require custom repositories.

### Beginning with sickbeard

The very basic steps needed for a user to get the module up and running. 

## Usage

Include the module to use it.
```puppet
node sb_server.example.net {
   include sickbeard
}
```

## Reference

Includes the standard install, config, service layout.

## Limitations

Limited to Puppet 3.0+.

Compatible with RedHat and Suse type Linux Operating Systems.

## Development

Apache 2.0 licensed. Forks welcome.  Contributions more welcome.


## Release Notes/Contributors/Etc

See CHANGELOG
