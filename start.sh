#!/bin/bash
mkdir -p ~/.google_workspace_mcp/credentials

# Fetch a fresh access token on every container start (handles Render spin-down)
TOKEN_RESPONSE=$(curl -s -X POST https://oauth2.googleapis.com/token \
  -d "client_id=$GOOGLE_OAUTH_CLIENT_ID" \
  -d "client_secret=$GOOGLE_OAUTH_CLIENT_SECRET" \
  -d "refresh_token=$GOOGLE_WORKSPACE_REFRESH_TOKEN" \
  -d "grant_type=refresh_token")

ACCESS_TOKEN=$(echo "$TOKEN_RESPONSE" | python3 -c "import sys,json; print(json.load(sys.stdin).get('access_token',''))")

if [ -z "$ACCESS_TOKEN" ]; then
  echo "WARNING: Failed to get access token. Token response:"
  echo "$TOKEN_RESPONSE"
fi

cat > ~/.google_workspace_mcp/credentials/ryan@albertaskylights.ca.json << EOF
{
  "token": "$ACCESS_TOKEN",
  "refresh_token": "$GOOGLE_WORKSPACE_REFRESH_TOKEN",
  "token_uri": "https://oauth2.googleapis.com/token",
  "client_id": "$GOOGLE_OAUTH_CLIENT_ID",
  "client_secret": "$GOOGLE_OAUTH_CLIENT_SECRET"
}
EOF

workspace-mcp --transport streamable-http --single-user --tool-tier extended
