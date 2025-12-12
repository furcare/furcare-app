# FurCare App - Deployment Guide

This guide explains how to deploy the FurCare Flutter web app using various deployment methods.

## Deployment Methods

- **Vercel** (Recommended) - Easiest, free tier available, automatic HTTPS
- **Docker** - Self-hosted, full control, works on any cloud provider

---

## Method 1: Vercel Deployment (Recommended)

Vercel is the easiest way to deploy your Flutter web app with zero configuration needed for HTTPS and CDN.

### Prerequisites
- A [Vercel account](https://vercel.com/signup) (free)
- Your code in a Git repository (GitHub, GitLab, or Bitbucket)

### Deploy via Vercel Dashboard (Easiest)

1. Push your code to GitHub/GitLab/Bitbucket

2. Go to [vercel.com](https://vercel.com) and sign in

3. Click "Add New Project"

4. Import your repository

5. Vercel will automatically detect the `vercel.json` configuration

6. Click "Deploy"

That's it! Vercel will:
- Build your Flutter web app
- Deploy it to a global CDN
- Provide you with a URL (e.g., `furcare-app.vercel.app`)
- Automatically deploy updates when you push to your repository
- Provide free HTTPS

### Deploy via Vercel CLI

1. Install Vercel CLI:
```bash
npm install -g vercel
```

2. Login to Vercel:
```bash
vercel login
```

3. Deploy from your project directory:
```bash
vercel
```

4. For production deployment:
```bash
vercel --prod
```

### Custom Domain

To use your own domain:

1. Go to your project settings in Vercel dashboard
2. Navigate to "Domains"
3. Add your custom domain
4. Update your DNS settings as instructed

### Environment Variables

If your app needs environment variables:

1. Go to Project Settings → Environment Variables
2. Add your variables
3. Redeploy the app

### Vercel Configuration

The `vercel.json` file configures:
- Build command for Flutter web
- Output directory (`build/web`)
- URL rewriting for Flutter routing
- Security headers
- Cache headers for static assets

---

## Method 2: Docker Deployment

Use Docker for self-hosted deployment or when you need more control.

### Prerequisites

- Docker installed on your system ([Download Docker](https://www.docker.com/get-started))
- Docker Compose installed (comes with Docker Desktop)

## Quick Start

### Option 1: Using Docker Compose (Recommended)

1. Build and start the application:
```bash
docker-compose up -d
```

2. Access the app at: `http://localhost:8080`

3. Stop the application:
```bash
docker-compose down
```

### Option 2: Using Docker directly

1. Build the Docker image:
```bash
docker build -t furcare-app .
```

2. Run the container:
```bash
docker run -d -p 8080:80 --name furcare-app furcare-app
```

3. Access the app at: `http://localhost:8080`

4. Stop and remove the container:
```bash
docker stop furcare-app
docker rm furcare-app
```

## Configuration

### Change Port

To use a different port (e.g., port 3000), modify `docker-compose.yml`:
```yaml
ports:
  - "3000:80"  # Change 8080 to your desired port
```

Or with Docker directly:
```bash
docker run -d -p 3000:80 --name furcare-app furcare-app
```

### Rebuild After Code Changes

When you make changes to your Flutter code:
```bash
docker-compose up -d --build
```

Or with Docker directly:
```bash
docker build -t furcare-app .
docker stop furcare-app
docker rm furcare-app
docker run -d -p 8080:80 --name furcare-app furcare-app
```

## Deployment to Production

### Using a Cloud Provider

#### Deploy to DigitalOcean, AWS, or Google Cloud:

1. Push your code to a Git repository
2. Connect your repository to the cloud provider
3. Use the Dockerfile for automatic builds
4. Set environment variables as needed

#### Deploy using Docker Hub:

1. Tag and push your image:
```bash
docker build -t your-username/furcare-app:latest .
docker push your-username/furcare-app:latest
```

2. Pull and run on your server:
```bash
docker pull your-username/furcare-app:latest
docker run -d -p 80:80 --name furcare-app your-username/furcare-app:latest
```

### SSL/HTTPS Setup

For production, use a reverse proxy like Nginx or Traefik with Let's Encrypt:

```yaml
# docker-compose.yml with SSL
version: '3.8'

services:
  furcare-web:
    build: .
    container_name: furcare-app
    restart: unless-stopped
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.furcare.rule=Host(`yourdomain.com`)"
      - "traefik.http.routers.furcare.entrypoints=websecure"
      - "traefik.http.routers.furcare.tls.certresolver=myresolver"
```

## Troubleshooting

### Container won't start
Check logs:
```bash
docker-compose logs
```

Or:
```bash
docker logs furcare-app
```

### Port already in use
Change the port in `docker-compose.yml` or stop the service using that port.

### Build fails
Clear Docker cache and rebuild:
```bash
docker-compose build --no-cache
docker-compose up -d
```

## Files Overview

### Vercel Deployment Files
- `vercel.json` - Vercel build and deployment configuration
- `.vercelignore` - Files to exclude from Vercel deployment

### Docker Deployment Files
- `Dockerfile` - Multi-stage build configuration
- `docker-compose.yml` - Docker Compose orchestration
- `nginx.conf` - Nginx web server configuration
- `.dockerignore` - Files to exclude from Docker build

## Support

For issues or questions, check the main README.md or create an issue in the project repository.
