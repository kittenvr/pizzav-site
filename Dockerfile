# Build stage: Build the Hugo site
FROM klakegg/hugo:ext-alpine as builder

WORKDIR /src
COPY . .

RUN hugo --minify

# Serve stage: Serve the built site with Caddy
FROM caddy:2-alpine
RUN apk add --no-cache ca-certificates

COPY --from=builder /src/public /usr/share/caddy/public
COPY Caddyfile /etc/caddy/Caddyfile

EXPOSE 80
CMD ["caddy", "run", "--config", "/etc/caddy/Caddyfile"]