FROM polarlightning/clightning:23.02.2

RUN apt-get update
RUN apt-get install -y iputils-ping

# add pyln-client needed for python plugin
RUN pip install pyln-client

# copy the plugins directory down
COPY ./plugins/ /plugins/

RUN chmod +x /plugins/*.py

RUN alias lightning-cli="lightning-cli --network regtest"