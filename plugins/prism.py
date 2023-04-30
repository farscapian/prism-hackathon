#!/usr/bin/env python3
import time
from pyln.client import Millisatoshi, Plugin, RpcError
plugin = Plugin() # This is our plugin's handle
 
@plugin.init() # Decorator to define a callback once the `init` method call has successfully completed
def init(options, configuration, plugin, **kwargs):
    plugin.log("Plugin prism.py initialized")


#  destination, amount, request
@plugin.method("prism")
def prism(plugin, name="world"):
    try:
        print('inside createPrism')
        destination = plugin.get_option('destination')
        s = '{}'.format(destination)
        plugin.log(s)
        return s
    except RpcError as e:
        print(e)

plugin.add_option('destination', 'destination', 'default_destination')


@plugin.subscribe("connect")
def on_connect(plugin, id, address, **kwargs):
    plugin.log("Received connect event for peer {}".format(id))


@plugin.subscribe("disconnect")
def on_disconnect(plugin, id, **kwargs):
    plugin.log("Received disconnect event for peer {}".format(id))

@plugin.hook("htlc_accepted")
def on_htlc_accepted(onion, htlc, plugin, **kwargs):
    plugin.log('on_htlc_accepted called')
    time.sleep(20)
    return {'result': 'continue'}

plugin.run() # Run our plugin