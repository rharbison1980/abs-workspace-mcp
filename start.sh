#!/bin/bash
mkdir -p ~/.google_workspace_mcp/credentials
cat > ~/.google_workspace_mcp/credentials/ryan@albertaskylights.ca.json << EOF
{
  "token": null,
  "refresh_token": "$GOOGLE_WORKSPACE_REFRESH_TOKEN",
  "token_uri": "https://oauth2.googleapis.com/token",
  "client_id": "$GOOGLE_OAUTH_CLIENT_ID",
  "client_secret": "$GOOGLE_OAUTH_CLIENT_SECRET"
}
EOF
workspace-mcp --transport streamable-http --single-user --tool-tier extended
