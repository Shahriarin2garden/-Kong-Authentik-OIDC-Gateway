# Kong + Authentik OIDC Gateway

Secure microservices with Kong API Gateway and Authentik as an OpenID Connect (OIDC) Identity Provider.

## Features

- **OIDC Integration**: Token issuance & validation via Authentik
- **Multi‑Grant Flows**: Password Credentials and Client Credentials
- **RBAC Enforcement**: Group‑based access with Kong ACL plugin
- **Performance**: DB‑less mode, local rate limiting (100 req/min), cached JWKS/introspection
- **Extensibility**: Add Redis, mTLS, Kong Konnect workspaces
- **Declarative**: All settings in YAML for GitOps
- **Demo‑Ready**: Mock services, test script, step‑by‑step setup

## Prerequisites

You need Docker & Docker Compose (v3.8+), a hosts entry mapping `gateway.example.com` to `127.0.0.1`, and the CLI tools `curl` and `jq` installed.

## Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/your-org/kong-authentik-oidc-gateway.git
   cd kong-authentik-oidc-gateway
