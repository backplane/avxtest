FROM busybox:musl

# see: https://fastest.fish/test-files
COPY 1MiB.bin 1.544MiB.bin sums.txt /

RUN set -eux; \
  cat /proc/cpuinfo;

RUN set -eux; \
  ulimit -c unlimited; \
  sha256sum *.bin || echo "fail"
