#!/bin/bash
# This script was written by Alessandro Accardo
# You can redistribute or modify or whatever you want to do with this piece of code, under the terms of the GNU GPL v3
# Copyright © Alessandro Accardo.


function getvalue() { # Much less complicated to read
	egrep -i ^$2=\".*\" $1 | cut -d'"' -f2
}

function do-keyvalue-action() {
    local action="$1"
    local onlykey="$2"
    local key="$3"
    local value="$4"
    local prettyfmt="$5"

    case "$onlykey" in
	"0")
	    if [ "$prettyfmt" == "1" ]; then local eq=" = "; else local eq="="; fi
	    $action "${key}${eq}${value}"
	    ;;
	"1")
	    $action "$key"
	    ;;
	"-1")
	    $action "$value"
	    ;;
    esac
}

function get-url-part() {
    local part="$1"
    local url="$2"

    case "$part" in
	proto)
	    echo $url | cut -d: -f1
	    ;;
	username)
	    echo $url | cut -d/ -f3 | cut -d@ -f1 -s | cut -d: -f1 -s
	    ;;
	password)
	    echo $url | cut -d/ -f3 | cut -d@ -f1 -s | cut -d: -f2 -s
	    ;;
	host)
	    echo $url | cut -d/ -f3 | cut -d@ -f2 | cut -d: -f1
	    ;;
	hostname)
	    echo $url | cut -d/ -f3 | cut -d@ -f2 | cut -d: -f1 | cut -d. -f1
	    ;;
	domain)
	    echo $url | cut -d/ -f3 | cut -d@ -f2 | cut -d: -f1 | rev | cut -d. -f1,2 | rev
	    ;;
	tld)
	    echo $url | cut -d/ -f3 | cut -d@ -f2 | cut -d: -f1 | rev | cut -d. -f1 | rev
	    ;;
	port)
	    echo $url | cut -d/ -f3 | cut -d@ -f2 | cut -d: -f2 -s
	    ;;
	path)
	    echo $url | cut -d/ -f4- -s | cut -d? -f1
	    ;;
	query)
	    echo $url | cut -d? -f2- -s | cut -d# -f1
	    ;;
	comment)
	    echo $url | cut -d# -f2 -s
	    ;;
    esac
}

function getsysproxyvar() {
    getvalue $PROXY_CONF $1
}

function toggleproxy() {
    [[ -z "$1" ]] && echo "Error! action argument empty!" && return 1
    local action="$1"
    local protocols=(`getsysproxyvar PROTOCOLS`)
    local modules=(`getsysproxyvar MODULES`)

    for mod in "${modules[@]}"
    do
	local mod_src=`dirname $PROXY_CONF`/modules/$mod.pxm
	echo Loading $mod_src...
	source $mod_src
    done
    unset mod

    for proto in "${protocols[@]}"
    do
	# Just to be sure that protocols come lowercase
	local proto="$(echo $proto | tr '[:upper:]' '[:lower:]')"

	# For each protocol I have to manage multiple modules
	for mod in "${modules[@]}"
	do
	    #echo "Module \"$mod\" is ${action}ing ${proto} proxy..."
	    do-proxy-conf-$mod-$action $proto
	done
	unset mod
    done
    unset mod
    return 0
}

function checkproxy() {
    toggleproxy "check"
}

function unsetproxy() {
    toggleproxy "disable"
    echo "Proxy disabled!"
}

function setproxy() {
    toggleproxy "enable"
    echo "Proxy enabled!"
}

function autoproxy() {
    local enabled="`getsysproxyvar ENABLED`"
    case "$enabled" in
	1|[yY]|[yY][eE][sS])
	    setproxy
	    ;;
	0|[nN]|[nN][oO])
	    unsetproxy
	    ;;
	*)
	    echo "Warning: nothing done. Variable 'ENABLED' not set or bad value."
	    ;;
    esac
}

autoproxy
