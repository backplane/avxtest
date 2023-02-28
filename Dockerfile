FROM busybox:musl AS bb
FROM alpine:edge

# see: https://fastest.fish/test-files
COPY 1MiB.bin 1.544MiB.bin sums.txt /
COPY --from=bb /bin/busybox /bin/busybox

RUN set -eux; \
  /bin/busybox --install /bin; \
  cat /proc/cpuinfo; \
  ulimit -c unlimited; \
  i=0; \
  while true; do \
  printf '%s\n' *.bin \
  | grep -F -f - sums.txt \
  | sha256sum -w -s -c - \
  || break; \
  i=$(( i + 1 )); \
  done; \
  echo "died on iteration ${i}"; \
