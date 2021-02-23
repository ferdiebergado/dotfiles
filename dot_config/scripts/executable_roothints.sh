#!/bin/bash
/usr/bin/curl -o /etc/unbound/root.hints https://www.internic.net/domain/named.cache
/usr/bin/unbound-anchor -a /etc/unbound/root.key -r /etc/unbound/root.hints 
/usr/bin/systemctl restart unbound.service
