FROM alpine:3.9.3

ADD run.sh run.sh
ADD backup.sh backup.sh

ENV POSTGRES_DATABASE **None**
ENV POSTGRES_HOST **None**
ENV POSTGRES_PORT 5432
ENV POSTGRES_USER **None**
ENV POSTGRES_PASSWORD **None**
ENV POSTGRES_EXTRA_OPTS ''
ENV S3_ACCESS_KEY_ID **None**
ENV S3_SECRET_ACCESS_KEY **None**
ENV S3_BUCKET **None**
ENV S3_REGION us-west-1
ENV S3_PREFIX 'backup'
ENV S3_ENDPOINT **None**
ENV S3_S3V4 no
ENV SCHEDULE **None**
ENV DB_ENV_PREFIX **None**

RUN apk --no-cache add \
          postgresql-client --repository=http://dl-cdn.alpinelinux.org/alpine/edge/main && \
          apk add --no-cache groff less python py-pip curl && \
          pip install --no-cache-dir awscli && \
          apk del py-pip py-setuptools && \
          curl -L --insecure https://github.com/odise/go-cron/releases/download/v0.0.6/go-cron-linux.gz | zcat > /usr/local/bin/go-cron && \
          chmod u+x /usr/local/bin/go-cron

CMD ["sh", "run.sh"]