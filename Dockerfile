FROM polarlightning/clightning:23.02.2

# add pyln-client needed for python plugin
RUN pip install pyln-client

# copy the plugins directory down
COPY ./plugins/ /plugins/

RUN chmod +x /plugins/*.py