## ROYGBIV

This repo helps you run a BOLT12-based PRISM environment in Polar Lighting.

## Instructions

1. First you need to run `./build.sh`. This creates a new core lightning image that contains the `prism.py` plugin and dependecies.
2. In Polar Lightning, click "Manage Images" in the top right, then click the "+Add a Custom Node" button at the top-right to create a custom image.
  - For Name enter `roygbiv/clightning`
  - For Implementation select `Core Lightning`
  - For Docker Image type `roygbiv/clightning:23.02.2`
  - For command, paste in the following text:

```bash
lightningd
  --alias={{name}}
  --addr={{name}}
  --addr=0.0.0.0:9735
  --network=regtest
  --bitcoin-rpcuser={{rpcUser}}
  --bitcoin-rpcpassword={{rpcPass}}
  --bitcoin-rpcconnect={{backendName}}
  --bitcoin-rpcport=18443
  --log-level=debug
  --dev-bitcoind-poll=2
  --dev-fast-gossip
  --grpc-port=11001
  --plugin=/opt/c-lightning-rest/plugin.js
  --rest-port=8080
  --rest-protocol=http
  --plugin=/plugins/prism.py
```

Great! Now that you have a custom implementation configured, you can create your polar dev environment as usual, just be sure to select the new image that contains all the prism functionality :)

## Notes

If you need to make updates to `prism.py`, be sure to stop your Polar Lightning dev environment first. Then you can modify `prism.py`, then re-execute `build.sh`. Then you can start your Polar Lightning environment.