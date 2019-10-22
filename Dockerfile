
ARG IMAGE_ARG_KIBANA_IMAGE_NAME
ARG IMAGE_ARG_KIBANA_IMAGE_VERSION

FROM docker.elastic.co/kibana/${IMAGE_ARG_KIBANA_IMAGE_NAME:-kibana-oss}:${IMAGE_ARG_KIBANA_IMAGE_VERSION:-7.4.0} as base

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

# Unable to remove plugin because of error: "You are using the standard distribution of Kibana.
# Please install the OSS-only distribution to remove X-Pack features."
# Remove X-Pack.
#RUN set -ex \
#  && kibana-plugin remove x-pack

CMD ["/bin/bash", "/usr/local/bin/kibana-docker"]
