This repo contains metadata to configure a fresh Trailhead Org (or Developer Org) for package development. The Org can be used as a deployment Org in CircleCI or for testing the orb and its scripts locally.

# Get Started

## Create a new Trailhead Org

First, visit [your trailhead profile](https://trailhead.salesforce.com/de/users/profiles/orgs) to create a new Playground.

Then, authenticate your local CLI with the Playground (you may need to reset password in the process)

## Prepare Trailhead Org

Prepare JWT key files and certificates (complete the prompts if needed).

```bash
zsh scripts/shell/generate-jwt-and-cert.sh -p mypassword
```

Deploy the metadata to the target org.

```bash
sfdx source:deploy -p src/deploy -u OrbDevelopmentOrg
```

Open the connected app and upload your server.crt to the app `CircleCI`
