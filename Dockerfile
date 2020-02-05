FROM alpine:latest AS build
RUN apk update \
    && apk upgrade \
    && apk add --no-cache build-base gcc abuild binutils cmake git \
    && cd / \
    && git clone https://github.com/Wind4/vlmcsd.git \
    && cd vlmcsd \
    && make \
    && chmod +x bin/vlmcsd

FROM alpine:latest
WORKDIR /usr/local/bin
COPY --from=build /vlmcsd/bin/vlmcsd .
RUN adduser -D vlmcsd 
USER vlmcsd
EXPOSE 1688
CMD ["./vlmcsd", "-D", "-d", "-t", "3", "-e", "-v"]


