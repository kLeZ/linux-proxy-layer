linux-proxy-layer
=================

This is a collection of scripts and some configuration to handle proxies on a Linux distro (tested only on Gentoo)

Installation
=================
In order to install linux-proxy-layer you need to install manually the files in tle list given below (an installa script will come sooner):

<table>
	<tr>
		<th>Type</th>
		<th>Filename</th>
		<th>Path</th>
	</tr>
	<tr>
		<td>f</td>
		<td>proxy.sh</td>
		<td>/etc/profile.d/</td>
	</tr>
	<tr>
		<td>f</td>
		<td>proxify</td>
		<td>/usr/local/bin/</td>
	</tr>
	<tr>
		<td>d</td>
		<td>proxy</td>
		<td>/etc/conf.d/</td>
	</tr>
</table>

and set the PROXY_CONF var to your configuration file inside /etc/conf.d/proxy/
