#!/bin/bash

set -ex

docker exec -it -u 1000:1000 -it polar-n1-backend1 bitcoin-cli -regtest -generate 50

# send coins to each core ln node from bitcoind wallet
for NODE in bob alice; do
    ADDR=$(docker exec -it "polar-n1-$NODE" lightning-cli --network regtest newaddr | jq -r '.bech32')
    docker exec -it -u 1000:1000 polar-n1-backend1 bitcoin-cli -regtest sendtoaddress "$ADDR" 1
done

docker exec -it -u 1000:1000 -it polar-n1-backend1 bitcoin-cli -regtest -generate 50

# Get node pubkeys
ALICE_PUBKEY=$(docker exec -it polar-n1-alice lightning-cli --network regtest getinfo | jq -r '.id')
CAROL_PUBKEY=$(docker exec -it polar-n1-carol lightning-cli --network regtest getinfo | jq -r '.id')
DAVE_PUBKEY=$(docker exec -it polar-n1-dave lightning-cli --network regtest getinfo | jq -r '.id')

# now open P2P connections
## from bob to alice
BOB_ALICE_PEERID=$(docker exec -it polar-n1-bob lightning-cli --network regtest connect "$ALICE_PUBKEY" alice 9735 | jq -r '.id')
sleep 1
## from alice to carol
ALICE_CAROL_PEERID=$(docker exec -it polar-n1-alice lightning-cli --network regtest connect "$CAROL_PUBKEY" carol 9735 | jq -r '.id')
sleep 1
## from alice to dave
ALICE_DAVE_PEERID=$(docker exec -it polar-n1-alice lightning-cli --network regtest connect "$DAVE_PUBKEY" dave 9735 | jq -r '.id')
sleep 1


# now let's create some channels
## from bob to alice
docker exec -it polar-n1-bob lightning-cli --network regtest fundchannel "$BOB_ALICE_PEERID" 250000
docker exec -it -u 1000:1000 -it polar-n1-backend1 bitcoin-cli -regtest -generate 5
sleep 3

## from alice to carol
docker exec -it polar-n1-alice lightning-cli --network regtest fundchannel "$ALICE_CAROL_PEERID" 250000
docker exec -it -u 1000:1000 -it polar-n1-backend1 bitcoin-cli -regtest -generate 5
sleep 3

## from alice to dave
docker exec -it polar-n1-alice lightning-cli --network regtest fundchannel "$ALICE_DAVE_PEERID" 250000
docker exec -it -u 1000:1000 -it polar-n1-backend1 bitcoin-cli -regtest -generate 5