# Kong + Authentik OIDC Gateway

End-to-end API security with Kong API Gateway and Authentik as an OpenID Connect (OIDC) Identity Provider, featuring token validation, multiple OAuth2 flows, RBAC enforcement, and performance optimization.

---

## 📋 Features

* **OIDC Integration**: Seamless token issuance and introspection-based validation via Authentik.
* **Multi-Grant Flows**: Resource Owner Password Credentials and Client Credentials supported out of the box.
* **RBAC Enforcement**: Group-based access control using Kong’s ACL plugin.
* **Performance Tuning**: DB-less mode, local rate limiting (100 req/min), plus cached JWKS/introspection.
* **GitOps-Friendly**: All configuration in declarative YAML for version-controlled deployments.
* **Self-Contained Demo**: Includes mock services, a robust test script, and detailed setup docs.

---

## 📁 Repository Structure

```
kong-authentik-oidc-gateway/
├── README.md                  # Project overview and instructions
├── LICENSE                    # MIT License
├── docker-compose.yml         # Docker Compose stack definition
├── kong/
│   └── kong.yml               # Kong declarative configuration
├── policies/
│   └── access-policies.yaml   # RBAC policy definitions
├── init/
│   └── authentik-setup.md     # Authentik initial setup guide
└── scripts/
    └── test.sh                # End-to-end testing script
```

---

## ⚙️ Prerequisites

Ensure you have Docker & Docker Compose (v3.8+), a hosts entry mapping `gateway.example.com` to `127.0.0.1`, and the CLI tools `curl` and `jq`.

*Add this line to your `/etc/hosts` (or Windows hosts file):*

```
127.0.0.1 gateway.example.com
```

---

## 🚀 Installation & Launch

1. **Clone the repository**

   ```bash
   git clone https://github.com/Shahriarin2garden/-Kong-Authentik-OIDC-Gateway.git
   cd -Kong-Authentik-OIDC-Gateway
   ```

2. **Start all services**

   ```bash
   docker-compose up -d
   ```

3. **Verify containers**

   ```bash
   docker-compose ps
   ```

   All services (Kong, Authentik, service-a, service-b) should be `Up`.

---

## 🔧 Configuration

### 1. Authentik Setup

* Open [http://localhost:8002](http://localhost:8002) and log in (`admin`/`adminpass`).
* Follow `init/authentik-setup.md` to:

  1. Create Groups: `service-a-group` and `service-b-group`.
  2. Create an OIDC Provider (`kong-client`/`secret`) with correct redirect and discovery URLs.
  3. Create Users: `userA` → `service-a-group`; `userB` → `service-b-group`.

### 2. Import Kong Config

```bash
docker-compose exec kong \
  kong config db_import /usr/local/kong/declarative/kong.yml
```

This loads services, routes, and plugins (OIDC, ACL, rate limiting) into Kong.

---

## ✅ Running End-to-End Tests

1. **Make the test script executable**

   ```bash
   chmod +x scripts/test.sh
   ```

2. **Execute the tests**

   ```bash
   ./scripts/test.sh
   ```

**Expected Output:**

```
[TEST] Service A (password grant)
→ Token OK
→ Response: Hello from Service A
---
[TEST] Service B (client credentials)
→ Token OK
→ Response: Hello from Service B
[INFO] All tests passed!
```

---

## 🎯 Meets Requirements

* **Token Validation**: Kong’s OIDC plugin introspects tokens via Authentik and caches JWKS.
* **Auth Flows**: Demonstrated password and client credentials grants; extendable to code/device grants.
* **RBAC**: ACL plugin enforces Authentik group memberships; policies defined in `access-policies.yaml`.
* **Performance**: DB-less mode, local rate limiting, introspection/JWKS caching for minimal latency.
* **GitOps-Ready**: Declarative YAML and Markdown docs enable CI/CD and version control.

---

## 🔒 Usage Scenarios

* Secure internal microservices with fine-grained RBAC.
* Rapidly prototype OAuth2/OIDC-protected APIs.
* Validate and test Kong plugin configurations in a reproducible demo.

---

## 📜 License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.
