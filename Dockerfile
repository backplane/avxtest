FROM busybox:musl AS bb
FROM alpine:edge

RUN apk add --no-cache strace

# see: https://fastest.fish/test-files
COPY 1MiB.bin 1.544MiB.bin sums.txt /
COPY --from=bb /bin/busybox /bin/busybox

RUN set -eux; \
  /bin/busybox --install /bin; \
  cat /proc/cpuinfo;

RUN set -eux; \
  ulimit -c unlimited; \
  strace sha256sum *.bin || echo "fail"
