linux-proxy-layer
=================

This is a collection of scripts and some configuration to handle proxies on a Linux distro (tested only on Gentoo)

Installation
============
In order to install linux-proxy-layer you need issue the following command: ~ # make install (as root).
Note that in the Makefile a file "02proxy" is created inside the /etc/env.d/ path.
If you do not have this path you simply need to set the PROXY_CONF env variable with the path to your configuration file inside /etc/conf.d/proxy/.

The default value for this var is "/etc/conf.d/proxy/default.conf", that is installed as a soft link pointing to /etc/conf.d/proxy/example.conf.

You also need to configure your proxy inside a configuration file based on the example.conf one, instructions on how to set the configuration properly are described in the file itself.


Components & Workflows
======================
This "layer" is made by three main components, and some variables:

<table>
	<tr>
		<th>Component</th>
		<th>Type</th>
		<th>Description</th>
	</tr>
	<tr>
		<td>proxy.sh</td>
		<td>Script file</td>
		<td>This is the main script.<br/>
			It is a collecion of bash functions that make the layer work.<br/>
			It is installed under /etc/profile.d/ because it needs to be loaded in the target environment to work.<br/>
			It can even work inside scripts if sourced.<br/>
			Contains the helper functions "getvalue" "do-keyvalue-action" "get-url-part" "getsysproxyvar" and the proxy-specific functions "toggleproxy" and "autoproxy".<br/>
			The functions "setproxy" "unsetproxy" and "checkproxy" are simply shortcuts to the toggleproxy function.<br/>
			<code>
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
			</code>
		</td>
	</tr>
</table>

