# 🚀 CollabEase Deployment Guide

## Quick Start with Docker (Recommended)

The easiest way to deploy CollabEase is using Docker Compose, which handles all dependencies automatically.

### Prerequisites
- Docker and Docker Compose installed on your system
- No other services running on ports 8080 and 3306

### One-Click Deployment

1. **Clone the repository:**
   ```bash
   git clone https://github.com/MohitBytes/CollabEase.git
   cd CollabEase
   ```

2. **Start the application:**
   ```bash
   docker compose up -d
   ```

3. **Access the application:**
   Open your browser and go to: `http://localhost:8080`

That's it! The application will be running with a MySQL database, and all tables will be created automatically.

### Stopping the Application
```bash
docker compose down
```

### Viewing Logs
```bash
# View all logs
docker compose logs

# View app logs only
docker compose logs app

# View database logs only
docker compose logs mysql
```

## Cloud Deployment Options

### 1. Deploy to Any Cloud Provider with Docker Support

You can deploy this application to any cloud provider that supports Docker:

- **AWS** (EC2, ECS, or Elastic Beanstalk)
- **Google Cloud Platform** (Compute Engine or Cloud Run)
- **Microsoft Azure** (Container Instances or App Service)
- **DigitalOcean** (Droplets or App Platform)
- **Heroku** (using heroku.yml)

### 2. Railway Deployment

1. Fork this repository
2. Connect your GitHub account to [Railway](https://railway.app)
3. Create a new project and select your forked repository
4. Railway will automatically detect the Docker configuration and deploy

### 3. Render Deployment

1. Fork this repository
2. Connect your GitHub account to [Render](https://render.com)
3. Create a new Web Service and select your repository
4. Render will build and deploy using the Dockerfile

### 4. Heroku Deployment

Create a `heroku.yml` file (already included) and deploy:

```bash
# Install Heroku CLI
heroku create your-app-name
heroku stack:set container
git push heroku main
```

## Environment Variables

You can customize the database connection using environment variables:

| Variable | Default | Description |
|----------|---------|-------------|
| `DB_HOST` | `mysql` | Database host |
| `DB_PORT` | `3306` | Database port |
| `DB_NAME` | `collabease_db` | Database name |
| `DB_USER` | `collabease` | Database username |
| `DB_PASSWORD` | `collabease123` | Database password |

## Manual Deployment (Advanced)

If you prefer to deploy without Docker, follow the original setup in the main README.md.

## Default Access

After deployment, you can register new users or create initial users through the registration page at:
`http://your-domain/signin/register.jsp`

## Security Notes

⚠️ **For Production Deployment:**

1. Change the default database password in `docker-compose.yml`
2. Use environment variables for sensitive data
3. Configure HTTPS/SSL termination
4. Set up proper firewall rules
5. Regular database backups

## Support

If you encounter any issues during deployment:

1. Check the logs using `docker compose logs`
2. Ensure ports 8080 and 3306 are not in use
3. Verify Docker and Docker Compose are properly installed
4. Create an issue on GitHub with error details

---

**Happy Collaborating! 🎉**