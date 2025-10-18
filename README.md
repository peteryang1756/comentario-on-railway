# Deploy and Host Comentario on Railway

Comentario is a lightweight, privacy-focused commenting engine that can be self-hosted on your own infrastructure. It provides an alternative to third-party commenting services like Disqus, giving you full control over your users' data and commenting experience.

## About Hosting Comentario

Hosting Comentario on Railway involves containerizing the application using Docker and configuring it to connect to a PostgreSQL database. Railway handles the infrastructure management, automatically deploying your containerized application and providing a managed PostgreSQL database. The deployment process includes setting up environment variables for database connection, which are then substituted into the configuration file during the build process.

## Common Use Cases

- Adding comments to personal blogs or static sites
- Enabling discussions on documentation websites
- Providing a privacy-focused commenting solution for content creators
- Replacing third-party commenting services with a self-hosted alternative

### Deployment Dependencies

- [Comentario Docker Image](https://gitlab.com/comentario/comentario) - The official container image
- [PostgreSQL on Railway](https://docs.railway.app/reference/postgres) - Managed database service

### Implementation Details

The deployment uses a Dockerfile that:

1. Pulls the official Comentario image
2. Copies a secrets template file
3. Installs envsubst for environment variable substitution
4. Substitutes database connection variables into the configuration

```dockerfile
FROM registry.gitlab.com/comentario/comentario

COPY secrets.template.yaml .

RUN apk add --no-cache envsubst

ARG POSTGRES_HOST
ARG POSTGRES_PORT
ARG POSTGRES_DATABASE
ARG POSTGRES_USERNAME
ARG POSTGRES_PASSWORD

RUN envsubst < secrets.template.yaml > secrets.yaml
```

## Configuration

To modify Comentario's configuration, you'll need to:

1. Update the `secrets.template.yaml` file with any additional configuration parameters you need
2. Add corresponding ARG declarations in the Dockerfile for each new environment variable
3. Set the environment variables in your Railway project settings

For example, if you want to add a new configuration parameter `SMTP_HOST`, you would:

1. Add it to `secrets.template.yaml`:

```yaml
postgres:
  host: $POSTGRES_HOST
  port: $POSTGRES_PORT
  database: $POSTGRES_DATABASE
  username: $POSTGRES_USERNAME
  password: $POSTGRES_PASSWORD
smtp:
  host: $SMTP_HOST
```

2. Add the ARG to your Dockerfile:

```dockerfile
ARG POSTGRES_HOST
ARG POSTGRES_PORT
ARG POSTGRES_DATABASE
ARG POSTGRES_USERNAME
ARG POSTGRES_PASSWORD
ARG SMTP_HOST
```

3. Set the SMTP_HOST environment variable in your Railway project settings

This ensures that all environment variables are properly substituted during the build process.

## Why Deploy Comentario on Railway?

Railway is a singular platform to deploy your infrastructure stack. Railway will host your infrastructure so you don't have to deal with configuration, while allowing you to vertically and horizontally scale it.

By deploying Comentario on Railway, you are one step closer to supporting a complete full-stack application with minimal burden. Host your servers, databases, AI agents, and more on Railway.
