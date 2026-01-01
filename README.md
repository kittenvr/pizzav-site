# PizzaV Site - Docker Deployment

This repository contains the PizzaV site deployed using Docker Compose with Hugo and Cloudflare Tunnel.

## Prerequisites

- Docker
- Docker Compose
- Cloudflare account with a configured tunnel

## Setup Instructions

### 1. Cloudflare Tunnel Setup

1. Install `cloudflared` locally:
   ```bash
   # For Ubuntu/Debian
   curl -L --output cloudflared.deb https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb
   sudo dpkg -i cloudflared.deb
   ```

2. Authenticate `cloudflared`:
   ```bash
   cloudflared tunnel login
   ```

3. Create a tunnel:
   ```bash
   cloudflared tunnel create pizzav-site
   ```

4. Copy the tunnel token from the output and add it to your `.env` file as `TUNNEL_TOKEN`.

5. Configure the tunnel to route traffic to your domain:
   ```bash
   cloudflared tunnel route dns pizzav-site pizzav.xyz
   ```

### 2. Environment Configuration

Copy the example environment file and update the values:

```bash
cp .env.example .env
```

Update the following values in your `.env` file:
- `TUNNEL_TOKEN`: Your Cloudflare tunnel token
- `DOMAIN`: Your domain name (defaults to pizzav.xyz)

### 3. Manual Deployment

Build and start the services:

```bash
docker-compose up -d --build
```

## GitHub Actions Deployment

This repository includes an automated deployment workflow using GitHub Actions. For this to work, you need to configure the following secrets in your GitHub repository settings:

1. Go to Settings → Secrets and variables → Actions
2. Add the following secrets:

- `HOST`: Your server's hostname or IP address
- `USERNAME`: Username for SSH access to your server
- `SSH_KEY`: Private SSH key with access to your server
- `PORT`: (Optional) SSH port (defaults to 22)
- `TUNNEL_TOKEN`: Your Cloudflare tunnel token

### Steps to set up GitHub Actions deployment:

1. Ensure Docker and Docker Compose are installed on your server
2. Add the required secrets to your GitHub repository
3. Push changes to the `main` branch to trigger deployment

## Development

To rebuild the site after making changes:

```bash
docker-compose down
docker-compose up -d --build
```

## Troubleshooting

- Check container logs: `docker-compose logs -f`
- If you have issues with Cloudflare Tunnel, verify your token and domain settings
- Ensure port 80 is available on your server
- Make sure your server has access to the internet to download container images