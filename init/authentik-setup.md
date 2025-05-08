```
## Authentik Initial Configuration

1. Access http://localhost:8002/ and login (admin/adminpass).

2. Create Groups:
   - service-a-group
   - service-b-group

3. Create OAuth2 (OIDC) Provider:
   - Name: kong-provider
   - Client ID: kong-client
   - Client Secret: secret
   - Redirect URIs: http://gateway.example.com:8000/callback
   - Discovery URL: http://authentik:8000/application/o/.well-known/openid-configuration
   - Introspection URL: http://authentik:8000/application/o/introspect/

4. Create Users:
   - userA / passwordA → service-a-group
   - userB / passwordB → service-b-group
```
