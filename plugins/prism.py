#!/usr/bin/env python3
import json
from pyln.client import  Plugin, RpcError, LightningRpc
plugin = Plugin()

@plugin.init() # Decorator to define a callback once the `init` method call has successfully completed
def init(options, configuration, plugin, **kwargs):
    plugin.log("Plugin prism.py initialized")


#  destination, amount, request
@plugin.method("prism")
def prism(plugin, label, members):
    try:
        plugin.log('inside prism')
        plugin.log(label, members)
        lrpc =  LightningRpc("/root/.lightning/regtest/lightning-rpc")
        offer = lrpc.offer("any", "label")
        lrpc.datastore(offer["bolt12"], json.dumps({label, members}))
        return offer
    except RpcError as e:
        plugin.log(e)
        return e

plugin.add_option('destination', 'destination', 'default_destination')


@plugin.subscribe("connect")
def on_connect(plugin, id, address, **kwargs):
    plugin.log("Received connect event for peer {}".format(id))


@plugin.subscribe("disconnect")
def on_disconnect(plugin, id, **kwargs):
    plugin.log("Received disconnect event for peer {}".format(id))

@plugin.subscribe("invoice_payment")
def on_payment(plugin, invoice_payment, **kwargs):
    plugin.log("Received invoice_payment event for label {label}, preimage {preimage},"
               " and amount of {msat}".format(**invoice_payment))
    plugin.log(invoice_payment)
    # we will check if bolt12 lookup in 
    return invoice_payment

plugin.run() # Run our plugin