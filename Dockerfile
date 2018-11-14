
ARG IMAGE_ARG_KIBANA_IMAGE_NAME
ARG IMAGE_ARG_KIBANA_IMAGE_VERSION

FROM docker.elastic.co/kibana/${IMAGE_ARG_KIBANA_IMAGE_NAME:-kibana}:${IMAGE_ARG_KIBANA_IMAGE_VERSION:-5.6.10} as base

FROM scratch

COPY --from=base / /

EXPOSE 5601

WORKDIR /usr/share/kibana

ENV ELASTIC_CONTAINER true
ENV PATH=/usr/share/kibana/bin:$PATH

RUN set -ex \
  && ls -la /usr/share/kibana \
  && chown kibana:kibana /usr/share/kibana/ \
  && mkdir -p /usr/share/kibana/log \
  && chown --recursive kibana:kibana config/ data/ log/ optimize/ plugins/

USER 1000

# Remove X-Pack.
RUN set -ex \
  && kibana-plugin remove x-pack

CMD ["/bin/bash", "/usr/local/bin/kibana-docker"]
