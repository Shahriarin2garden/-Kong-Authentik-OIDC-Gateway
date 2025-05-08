#!/usr/bin/env bash
set -euo pipefail
IFS=$'
	'

auth_url="http://localhost:8002/application/o"
client_id="kong-client"
client_secret="secret"

# Ensure prerequisites
for cmd in curl jq; do
  command -v $cmd >/dev/null || { echo "$cmd is not installed" >&2; exit 1; }
done

echo "[INFO] Running end-to-end OIDC tests..."

# Service A: Password Grant
echo "[TEST] Service A (password grant)"
resp=$(curl -s -w "
%{http_code}" -X POST "$auth_url/token/" \
  -d grant_type=password \
  -d username=userA \
  -d password=passwordA \
  -d client_id=$client_id \
  -d client_secret=$client_secret \
  -d scope="openid profile email")
body=$(echo "$resp" | sed '$ d')
code=$(echo "$resp" | tail -n1)
[[ $code -eq 200 ]] || { echo "Token fetch failed: $body" >&2; exit 1; }
token=$(echo $body | jq -r .access_token)
echo "→ Token OK"

echo "[CALL] GET /service-a"
out=$(curl -s -H "Authorization: Bearer $token" http://localhost:8000/service-a)
echo "→ Response: $out"

echo "---"

# Service B: Client Credentials
echo "[TEST] Service B (client credentials)"
resp=$(curl -s -w "
%{http_code}" -X POST "$auth_url/token/" \
  -d grant_type=client_credentials \
  -d client_id=$client_id \
  -d client_secret=$client_secret \
  -d scope="openid")
body=$(echo "$resp" | sed '$ d')
code=(echo "$resp" | tail -n1)
[[ $code -eq 200 ]] || { echo "Token fetch failed: $body" >&2; exit 1; }
token=$(echo $body | jq -r .access_token)
echo "→ Token OK"

echo "[CALL] GET /service-b"
out=$(curl -s -H "Authorization: Bearer $token" http://localhost:8000/service-b)
echo "→ Response: $out"

echo "[INFO] All tests passed!"
