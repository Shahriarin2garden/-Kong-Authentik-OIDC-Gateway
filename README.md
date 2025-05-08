# Kong + Authentik OIDC Gateway

End-to-end API security with Kong API Gateway and Authentik as an OpenID Connect (OIDC) Identity Provider, featuring token validation, multiple OAuth2 flows, RBAC enforcement, and performance optimization.

---

## 📋 Features

* **OIDC Integration**: Seamless token issuance and validation via Authentik.
* **Multi‑Grant Flows**: Supports Resource Owner Password Credentials and Client Credentials grants.
* **RBAC Enforcement**: Group‑based access control using Kong’s ACL plugin.
* **Performance Tuning**: Operates in DB‑less mode, with local rate limiting (100 req/min) and cached JWKS/introspection.
* **GitOps‑Friendly**: All configuration as declarative YAML for version-controlled deployments.
* **Self‑Contained Demo**: Includes mock services, an end‑to‑end test script, and setup documentation.

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

Ensure the following are installed and configured on your machine:

* **Docker** & **Docker Compose** (v3.8+)
* A hosts entry mapping `gateway.example.com` to `127.0.0.1`
* CLI tools: `curl` and `jq`

*Add the following line to your **`/etc/hosts`** (or Windows hosts file):*

```
127.0.0.1 gateway.example.com
```

---

## 🚀 Installation & Launch

1. **Clone the repository**

   ```bash
   git clone https://github.com/your-org/kong-authentik-oidc-gateway.git
   cd kong-authentik-oidc-gateway
   ```

2. **Start all services**

   ```bash
   docker-compose up -d
   ```

3. **Verify containers**

   ```bash
   docker-compose ps
   ```

   All services (Kong, Authentik, service‑a, service‑b) should be listed as `Up`.

---

## 🔧 Configuration

### 1. Authentik Setup

* Open your browser to [http://localhost:8002](http://localhost:8002)
* Login with:

  * **Username:** `admin`
  * **Password:** `adminpass`
* Follow `init/authentik-setup.md` to:

  1. Create groups: `service-a-group`, `service-b-group`.
  2. Create an OIDC provider (`kong-client`/`secret`) with appropriate redirect and discovery URLs.
  3. Create users `userA` and `userB`, assigning them to the respective groups.

### 2. Import Kong Declarative Config

Execute in a separate terminal:

```bash
docker-compose exec kong \
  kong config db_import /usr/local/kong/declarative/kong.yml
```

This loads services, routes, and plugins (OIDC, ACL, rate‑limiting) into Kong.

---

## ✅ Running End‑to‑End Tests

1. **Make the script executable**

   ```bash
   chmod +x scripts/test.sh
   ```

2. **Run the tests**

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

* **Token Validation**: Kong OIDC plugin introspects tokens via Authentik and caches JWKS.
* **Multiple Auth Flows**: Demonstrated password and client credentials grants; extendable to other flows.
* **RBAC & Policies**: ACL plugin enforces Authentik group memberships; `access-policies.yaml` defines roles.
* **Performance**: DB‑less mode, in‑process rate limiting, and cached introspection for minimal latency.
* **GitOps‑Ready**: Declarative YAML and Markdown docs facilitate version control and CI/CD.

---

## 🔒 Usage Scenarios

* Securing internal microservices with fine‑grained RBAC.
* Rapid prototyping of OAuth2/OIDC‑protected APIs.
* Testing and validating Kong plugin configurations.

---

## 📜 License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.
