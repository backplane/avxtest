ARG BASE=backplane/busybox:1.36.0-shani-patch
FROM backplane/busybox:1.36.0-shani-patch

# see: https://fastest.fish/test-files
COPY 1MiB.bin 1.544MiB.bin sums.txt /

RUN set -eux;
  # we know the problem hardware, let's just fail unless we're testing on it
  grep -E '8171M|8272CL' /proc/cpuinfo

RUN set -eux; \
  ulimit -c unlimited; \
  ! sha256sum *.bin
  # the goal to is get crash cores, if we didn't crash then we fail the build
RUN set -eux; \
  cat /proc/cpuinfo >/cpuinfo.txt; \
  cat /proc/meminfo >/meminfo.txt; \
  busybox | grep 'BusyBox v' >/busybox-version.txt; \
  cksum bin/busybox >/busybox-cksum.txt
