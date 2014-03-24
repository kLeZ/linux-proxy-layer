linux-proxy-layer
=================

This is a collection of scripts and some configuration to handle proxies on a Linux distro (tested only on Gentoo)

Installation
=================
In order to install linux-proxy-layer you need to install manually the files in tle list given below (an installa script will come sooner):
Type	 Filename   	      	Path
-------- -------------------	---------------------------
f  	 proxy.sh		/etc/profile.d/
f  	 proxify		/usr/local/bin/
d  	 proxy			/etc/conf.d/

and set the PROXY_CONF var to your configuration file inside /etc/conf.d/proxy/
