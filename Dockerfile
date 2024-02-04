FROM alpine:latest as prod
RUN apk update && apk add --no-cache perl make
ARG EXIFTOOL_VERSION=12.76
RUN wget -qO- https://exiftool.org/Image-ExifTool-${EXIFTOOL_VERSION}.tar.gz | tar -xvz -C /tmp
WORKDIR /tmp/Image-ExifTool-${EXIFTOOL_VERSION}
RUN perl Makefile.PL
RUN make test
RUN make install
WORKDIR /
ENTRYPOINT ["exiftool", "-json", "-b", "-a", "-c", "%.8f degrees", "-"]