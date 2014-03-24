# Makefile helping install/uninstall proxy-scripts in a target system
SHELL := /bin/bash

# Must end with a / (slash)
rootdir = /
prefix = $(rootdir)usr/local/
confdir = $(rootdir)etc/conf.d/
profiledir = $(rootdir)etc/profile.d/
envdir = $(rootdir)etc/env.d/

install: clean
	install -o root -g root -m 0644 proxy.sh $(profiledir)
	install -o root -g root -m 0755 proxify $(prefix)bin
	mkdir -p $(confdir)proxy/modules/
	install -o root -g root -m 0644 proxy/example.conf $(confdir)proxy
	ln -sf $(confdir)proxy/example.conf $(confdir)proxy/default.conf
	install -o root -g root -m 0644 proxy/modules/env.pxm $(confdir)proxy/modules
	install -o root -g root -m 0644 proxy/modules/svn.pxm $(confdir)proxy/modules
	echo -e "PROXY_CONF=\"$(confdir)proxy/default.conf\"\n" >> $(envdir)02proxy
uninstall:
	rm -f $(profiledir)proxy.sh
	rm -f $(prefix)bin/proxify
	rm -f $(confdir)proxy/example.conf
	rm -f $(confdir)proxy/default.conf
	rm -f $(confdir)proxy/modules/env.pxm
	rm -f $(confdir)proxy/modules/svn.pxm
	([ -d $(confdir)proxy/modules/ ] && rmdir --ignore-fail-on-non-empty $(confdir)proxy/modules/) || true
	([ -d $(confdir)proxy/ ] && rmdir --ignore-fail-on-non-empty $(confdir)proxy/) || true
	rm -f $(envdir)02proxy
clean:
	find . -regextype posix-extended -regex '\./(.*~|\..*~|\#.*\#)$' -delete
