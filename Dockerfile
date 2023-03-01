ARG BASE=busybox:musl
FROM ${BASE}

# see: https://fastest.fish/test-files
COPY 1MiB.bin 1.544MiB.bin sums.txt /

RUN cat /proc/cpuinfo;

RUN set -eux; \
  ulimit -c unlimited; \
  ! sha256sum *.bin
  # the goal to is get crash cores, if we didn't crash then we fail the build
