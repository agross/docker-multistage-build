# Build.
FROM alpine:latest as build
RUN apk add --no-cache build-base
WORKDIR /build
COPY app.c .
RUN gcc -o app app.c

# Runtime, no gcc available.
FROM alpine:latest
WORKDIR /app
COPY --from=build /build/app .
COPY docker-entrypoint .
ENTRYPOINT ["./docker-entrypoint"]
CMD ["run"]
