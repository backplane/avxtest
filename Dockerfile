FROM busybox:musl

# see: https://fastest.fish/test-files
COPY 1MiB.bin 1.544MiB.bin sums.txt /

RUN set -eux; \
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
