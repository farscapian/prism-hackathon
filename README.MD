## ROYGBIV

This repo helps you run a BOLT12-based PRISM test environment running in docker.

## Instructions

This repo deploys a test environment for testing prisms. We create a network of 4 CLN nodes, Bob, Alice, Carol, and Dave. `up.sh` and `resume.sh` scripts configure all the nodes such that there exists a channel between Bob and Alice, a channel between Alice and Carol, and a channel between Alice and Dave. The objective is to run the prism plugin on Alice, which will expose a BOLT12 offer. Bob will pay Alice using the BOLT12 offer created as a result of the Prism plugin.

You first need to run `up.sh`.  This file brings up the development environment according to the `docker-compose.yml` file. The script continues by using bitcoin-cli and lightning-cli to fund the nodes, advance the blockchain, send BTC to the various lightning nodes, add peer to peer connections, and open lightning channels.

Unfortunately, we had one issue where `up.sh` doesn't doesn't complete. Thus, you will need to copy the output and enter the final command manually. After it's completed, you can run `resume.sh` which completes the entire process.

## COnclusion

After the script completes successfully, you SHOULD be able to connect a web front-end to the ALice's core lightning websocket interface to issue RPC commands.

## down.sh

If you want to reset the entire thing, run down.sh. THis will take down your dev environment AND IT WILL DELETE any data from the previous attempt.