linux-proxy-layer
=================

This is a collection of scripts and some configuration to handle proxies on a Linux distro (tested only on Gentoo)

Installation
=================
In order to install linux-proxy-layer you need issue the following command: ~ # make install (as root).
Note that in the Makefile a file "02proxy" is created inside the /etc/env.d/ path.
If you do not have this path you simply need to set the PROXY_CONF env variable with the path to your configuration file inside /etc/conf.d/proxy/.

The default value for this var is "/etc/conf.d/proxy/default.conf", that is installed as a soft link pointing to /etc/conf.d/proxy/example.conf.

You also need to configure your proxy inside a configuration file based on the example.conf one, instructions on how to set the configuration properly are described in the file itself.
