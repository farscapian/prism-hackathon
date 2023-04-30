#!/bin/bash

docker volume create alice-certs



# creates wallet
docker exec -u 1000:1000 -it polar-n1-backend1 bitcoin-cli -regtest createwallet prism

docker exec -it -u 1000:1000 -it polar-n1-backend1 bitcoin-cli -regtest -generate 5


docker exec -it -u 1000:1000 -it polar-n1-backend1 bitcoin-cli -regtest getnewaddress

docker exec -it -u 1000:1000 -it polar-n1-backend1 bitcoin-cli -regtest generatetoaddress 101 "$ADDRESS"

docker exec -it -u 1000:1000 -it polar-n1-backend1 bitcoin-cli -regtest loadwallet prism

docker exec -it -u 1000:1000 -it polar-n1-backend1 bitcoin-cli -regtest listunspent
docker exec -it -u 1000:1000 -it polar-n1-backend1 bitcoin-cli -regtest 


# open a channel alice to bob
docker exec -it polar-n1-alice lightning-cli --network regtest newaddr



# send coins to alice core ln
docker exec -it -u 1000:1000 -it polar-n1-backend1 bitcoin-cli -regtest sendtoaddress bcrt1q63s2rknr7jd4fmjazddg3rrtsmlk3qjwgh7ed8 1


docker exec -it -u 1000:1000 -it polar-n1-backend1 bitcoin-cli -regtest generatetoaddress 101 bcrt1q62u5jxxkjt4kka880ctg9ge7rtlk594jtrdfhy

docker exec -it polar-n1-alice lightning-cli --network regtest listfunds

docker exec -it polar-n1-alice lightning-cli --network regtest listpeers


# get bob's channel ID
docker exec -it polar-n1-bob lightning-cli --network regtest getinfo

docker exec -it polar-n1-alice lightning-cli --network regtest connect 0399d4cb9e58e0129b70b5ed78628cacd7a47c06be867ee3c4688636f8eed92b2f@bob:9735
 # get channel ID from output

 docker exec -it polar-n1-alice lightning-cli --network regtest listpeers


docker exec -it polar-n1-alice lightning-cli --network regtest listfunds

docker exec -it polar-n1-alice lightning-cli --network regtest fundchannel 0399d4cb9e58e0129b70b5ed78628cacd7a47c06be867ee3c4688636f8eed92b2f 25000


docker exec -it polar-n1-alice lightning-cli --network regtest prism






# NOTES
lightning-cli prism createPrism 

lightning-cli offer any "description"


alias lighting-cli="lightning-cli --network regtest $@"

bcrt1qn632fxztu5ujnd7cnm32cdg4nz7gyhj6aqxrxh