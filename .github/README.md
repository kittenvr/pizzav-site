# GitHub Actions Setup

## Deployment Configuration

This repository uses GitHub Actions to deploy the site automatically on every commit to the main branch. The deployment can happen in two ways:

### Option 1: GitHub Pages (Default)
- The site is built and deployed to GitHub Pages automatically.
- No additional configuration needed.

### Option 2: SSH Deployment (Optional)
- If you want to deploy to your own server via SSH, you'll need to configure the following secrets in your repository settings:

1. `SSH_HOST` - Your server's hostname or IP address
2. `SSH_USERNAME` - Username for SSH connection
3. `SSH_PRIVATE_KEY` - Private SSH key with access to the server
4. `SSH_PORT` - SSH port (defaults to 22 if not specified)

After setting these secrets, the workflow will deploy to your server instead of GitHub Pages.

To change the deployment target directory in the workflow file, update the `target` parameter in `.github/workflows/deploy.yml`.