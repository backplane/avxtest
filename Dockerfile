FROM busybox:musl

# see: https://fastest.fish/test-files
COPY 1MiB.bin 1.544MiB.bin sums.txt /

USER 65534:64434

RUN set -eux; \
  ulimit -c unlimited; \
  # only check the sum of the files that are present
  printf '%s\n' *.bin \
  | grep -F -f - sums.txt \
  | sha256sum -w -s -c - \
  || :

