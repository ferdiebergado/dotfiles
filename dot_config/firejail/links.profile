# Firejail profile for elinks
# Description: Advanced text-mode WWW browser
# This file is overwritten after every install/update
# Persistent local customizations
include links.local
# Persistent global definitions
include globals.local

#blacklist /tmp/.X11-unix

noblacklist ${HOME}/.links

include disable-common.inc
include disable-devel.inc
include disable-interpreters.inc
include disable-passwdmgr.inc
include disable-programs.inc
include disable-xdg.inc

caps.drop all
netfilter
no3d
nodvd
nogroups
nonewprivs
noroot
nosound
notv
nou2f
novideo
protocol unix,inet,inet6
seccomp
shell none
tracelog

private-bin links,xlinks
private-cache
private-dev
private-etc ca-certificates,ssl,pki,crypto-policies
private-tmp
