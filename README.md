```markdown
# Kong + Authentik OIDC Gateway

End-to-end API security layer using Kong (API Gateway) and Authentik (OIDC IdP).


---

## 📁 Repository Structure

```
kong-authentik-oidc-gateway/
├── README.md
├── docker-compose.yml
├── kong/
│   └── kong.yml
├── policies/
│   └── access-policies.yaml
├── init/
│   └── authentik-setup.md
└── scripts/
    └── test.sh
```

---



## Prerequisites

- Docker & Docker Compose v3.8+
- Edit `/etc/hosts` to include:
```

127.0.0.1 gateway.example.com

````
- Install `curl` and `jq`

## Quickstart

1. **Clone & Launch**
 ```bash
 git clone https://github.com/your-org/kong-authentik-oidc-gateway.git
 cd kong-authentik-oidc-gateway
 docker-compose up -d
````

2. **Configure Authentik**

   * Open [http://localhost:8002](http://localhost:8002) in your browser.
   * Log in (admin/adminpass).
   * Follow `init/authentik-setup.md`.

3. **Import Kong Configuration**

   ```bash
   docker-compose exec kong \
     kong config db_import /usr/local/kong/declarative/kong.yml
   ```

4. **Run End-to-End Tests**

   ```bash
   chmod +x scripts/test.sh
   ./scripts/test.sh
   ```

You should see successful responses from Service A & Service B.

````




## ✅ Meets Requirements

* **Token Validation**: OIDC plugin with introspection and JWKS caching.
* **Auth Flows**: Password & client\_credentials (extendable).
* **RBAC**: ACL plugin and `access-policies.yaml`.
* **Performance**: DB-less mode, local rate limiting, cached introspection.
* **Scalability**: Plug-and-play Redis, mTLS, multi-tenant Konnect.

