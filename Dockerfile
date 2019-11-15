FROM alpine as builder

ENV SBT_VERSION=1.2.6

RUN mkdir -pv "/tmp/sbt"
RUN wget -O - "https://github.com/sbt/sbt/releases/download/v$SBT_VERSION/sbt-$SBT_VERSION.tgz" \
    | tar xzf - -C "/tmp/sbt" --strip-components=1


# ---------------------------------
FROM openjdk:jre-alpine

# sbt requires bash at run-time.
RUN apk add --no-cache --update bash

COPY --from=builder /tmp/sbt /usr/local/sbt
RUN ln -sv /usr/local/sbt/bin/sbt /usr/bin/
