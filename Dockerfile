FROM rabbitmq:3-management-alpine

ENV RABBITMQ_AUTOCLUSTER_VERSION 0.8.0

RUN apk update --no-cache && \
    apk add --no-cache ca-certificates wget curl jq supervisor && \
    update-ca-certificates

RUN wget -q -O "${RABBITMQ_HOME}/plugins/autocluster-${RABBITMQ_AUTOCLUSTER_VERSION}.ez" "http://github.com/rabbitmq/rabbitmq-autocluster/releases/download/${RABBITMQ_AUTOCLUSTER_VERSION}/autocluster-${RABBITMQ_AUTOCLUSTER_VERSION}.ez" && \
    wget -q -O "${RABBITMQ_HOME}/plugins/rabbitmq_aws-${RABBITMQ_AUTOCLUSTER_VERSION}.ez" "http://github.com/rabbitmq/rabbitmq-autocluster/releases/download/${RABBITMQ_AUTOCLUSTER_VERSION}/rabbitmq_aws-${RABBITMQ_AUTOCLUSTER_VERSION}.ez"

RUN rabbitmq-plugins enable --offline autocluster

COPY assets/scripts/*.sh /usr/local/bin/
COPY assets/supervisor/supervisord.conf /etc/supervisor/
COPY assets/supervisor/conf.d/*.conf /etc/supervisor/conf.d/
RUN chmod 755 /usr/local/bin/*.sh

CMD ["app:start"]