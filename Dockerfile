FROM rust:1-bookworm AS build

ADD build-holo.sh /

RUN ./build-holo.sh

FROM ligato/vpp-base:25.06-release

ADD run.sh /

RUN \
    groupadd -r holo \
    && mkdir /var/opt/holo \
    && useradd --system --shell /sbin/nologin --home-dir /var/opt/holo/ -g holo holo

COPY --from=build /holo/target/release/holod /usr/bin/holod
COPY --from=build /holo-cli/target/release/holo-cli /usr/bin/holo-cli
COPY --from=build /holo/holo-daemon/holod.toml /etc

CMD /run.sh
