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
				function checkproxy() {<br/>
					toggleproxy "check"<br/>
				}<br/>
<br/>
				function unsetproxy() {<br/>
					toggleproxy "disable"<br/>
					echo "Proxy disabled!"<br/>
				}<br/>
<br/>
				function setproxy() {<br/>
					toggleproxy "enable"<br/>
					echo "Proxy enabled!"<br/>
				}
			</code>
		</td>
	</tr>
	<tr>
		<td>proxify</td>
		<td>Script file</td>
		<td>
			This script handles the on-demand execution of the proxy layer set/unset. It is in fact a quite simple script that calls setproxy, then calls the $@ argument (the command you called in) and then it calls unsetproxy.<br/>
			A mechanism that is quite important to note is the use of the DISABLE_AUTOPROXY env variable used in the autoproxy function.<br/>
			It simply saves the DISABLE_AUTOPROXY value, it sets DISABLE_AUTOPROXY value to "1" and does all the stuff. Then it reset the DISABLE_AUTOPROXY var to its previous value.
		</td>
	</tr>
</table>

