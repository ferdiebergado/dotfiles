# Firejail profile for cawbird
# Description: Native Gtk+ Twitter client for the Linux desktop
# This file is overwritten after every install/update
# Persistent local customizations
include cawbird.local
# Persistent global definitions
include globals.local

noblacklist ${HOME}/.config/cawbird

include disable-common.inc
include disable-devel.inc
include disable-exec.inc
include disable-interpreters.inc
include disable-passwdmgr.inc
include disable-programs.inc
include disable-xdg.inc

include whitelist-var-common.inc

caps.drop all
netfilter
nodvd
nogroups
nonewprivs
noroot
notv
nou2f
novideo
protocol unix,inet,inet6
seccomp
shell none

private-bin cawbird,chromium
private-dev
private-tmp
