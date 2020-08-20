FROM luzifer/archlinux

LABEL maintainer Knut Ahlers <knut@ahlers.me>

COPY build.sh /usr/local/bin/

RUN set -ex \
 && /usr/local/bin/build.sh

ENTRYPOINT ["/usr/local/bin/inner-runner"]
CMD ["--"]

