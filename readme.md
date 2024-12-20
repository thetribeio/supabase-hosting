# Supabase self-hosted (on Scaleway)

## Configuring the variables

```
# Copy the .env file
cp .env.example .env
```

Then, update the following variables in `.env`:

- `POSTGRES_PASSWORD`: Generate it randomly.
- `DASHBOARD_USERNAME`: Generate it randomly.
- `DASHBOARD_PASSWORD`: Generate it randomly.

To generate a random password, use the following command:

```
openssl rand -base64 8 |md5 |head -c32 ; echo
```

For the next three variables, follow the instructions here: https://supabase.com/docs/guides/self-hosting/docker#generate-api-keys

- `JWT_SECRET`
- `ANON_KEY`
- `SERVICE_ROLE_KEY`

Once you've done this, store the `.env` somewhere secure (for example passbolt).

## Creating the infrastructure with `terraform`

If it doesn't exist, create your project on Scaleway: https://console.scaleway.com/organization

Then, select it and copy its project ID.

Inside the `terraform/` directory, you'll find everything needed to configure infra deployment.

There are two files: `staging.tf`, `production.tf`. You need to edit both of them before they can be used, to set the s3 backend configuration.

It's recommended to not deploy anything with less than 30GB in storage, because of the size of the Docker images (and also the Supabase database).

## Create the DNS zone entry

For the staging, update the thestaging.io domain name: https://console.scaleway.com/domains/external/global/thestaging.io/overview

For the production, it depends on the project.

Then, update the domain name in the following files:

- TODO

## Deploying the Supabase service with `ansible`
