#!/bin/bash

set -x

docker system prune -f

if ! docker image list | grep -q "roygbiv/clightning"; then
    ./build.sh
fi

docker-compose up -d

sleep 20

# First lets create a wallet on our backend so we can fund the various CLN nodes.
if ! docker exec -u 1000:1000 -it polar-n1-backend1 [ -f /home/bitcoin/.bitcoin/regtest/wallets/prism ]; then
    docker exec -u 1000:1000 -it polar-n1-backend1 bitcoin-cli -regtest createwallet prism
else
    if ! docker exec -it -u 1000:1000 polar-n1-backend1 bitcoin-cli -regtest listwallets | grep -q prism; then
        docker exec -it -u 1000:1000 polar-n1-backend1 bitcoin-cli -regtest loadwallet prism
    fi
fi

# docker exec -it -u 1000:1000 polar-n1-backend1 bitcoin-cli -regtest getnewaddress
ADDR=$(docker exec -it -u 1000:1000 polar-n1-backend1 bitcoin-cli -regtest getnewaddress)
echo "$ADDR"

CMD="docker exec -it -u 1000:1000 polar-n1-backend1 bitcoin-cli -regtest generatetoaddress 101 $ADDR"
echo "Please run the following command manually. Afterwards, run resume.sh:  "
echo "$CMD"
