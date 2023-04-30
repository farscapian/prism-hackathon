## ROYGBIV

This repo helps you run a BOLT12-based PRISM environment in Polar Lighting.

## Instructions

This repo deploys a test environment for prism use. We create a network of 4 CLN nodes, Bob, Alice, Carol Dave. The up.sh and resume.sh script configure all the nodes such that there exists a channel between Bob and Alice, a Channel between Alice and Carol, and a channel between Alice and Dave. The objective is to run the prism plugin on Alice, which will expose a BOLT12 offer. Bob will pay Alice using the BOLT12 offer created as a result of the Prism plugin.  When the invoice gets get