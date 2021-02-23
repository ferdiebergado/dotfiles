#!/bin/bash
arptables -A INPUT ! -s 192.168.1.1 -j DROP; arptables -A OUTPUT ! -d 192.168.1.1 -j DROP
