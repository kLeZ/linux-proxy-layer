# Makefile helping install/uninstall proxy-scripts in a target system
SHELL := /bin/bash

# Must end with a / (slash)
ROOT_PREFIX = /
USR_PREFIX = $(ROOT_PREFIX)usr/local/
CONF_PREFIX = $(ROOT_PREFIX)etc/conf.d/
PROFILE_PREFIX = $(ROOT_PREFIX)etc/profile.d/
ENV_PREFIX = $(ROOT_PREFIX)etc/env.d/

install: clean
	install -o root -g root -m 0644 proxy.sh $(PROFILE_PREFIX)
	install -o root -g root -m 0755 proxify $(USR_PREFIX)bin
	mkdir -p $(CONF_PREFIX)proxy/modules/
	install -o root -g root -m 0644 proxy/example.conf $(CONF_PREFIX)proxy
	ln -sf $(CONF_PREFIX)proxy/example.conf $(CONF_PREFIX)proxy/default.conf
	install -o root -g root -m 0644 proxy/modules/env.pxm $(CONF_PREFIX)proxy/modules
	install -o root -g root -m 0644 proxy/modules/svn.pxm $(CONF_PREFIX)proxy/modules
	echo -e "PROXY_CONF=\"$(CONF_PREFIX)proxy/default.conf\"\n" >> $(ENV_PREFIX)02proxy
uninstall:
	rm -f $(PROFILE_PREFIX)proxy.sh
	rm -f $(USR_PREFIX)bin/proxify
	rm -f $(CONF_PREFIX)proxy/example.conf
	rm -f $(CONF_PREFIX)proxy/default.conf
	rm -f $(CONF_PREFIX)proxy/modules/env.pxm
	rm -f $(CONF_PREFIX)proxy/modules/svn.pxm
	([ -d $(CONF_PREFIX)proxy/modules/ ] && rmdir --ignore-fail-on-non-empty $(CONF_PREFIX)proxy/modules/) || true
	([ -d $(CONF_PREFIX)proxy/ ] && rmdir --ignore-fail-on-non-empty $(CONF_PREFIX)proxy/) || true
	rm -f $(ENV_PREFIX)02proxy
clean:
	rm -rf *~
	rm -rf .*~
	rm -rf \#*#
