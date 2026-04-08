#!/bin/bash
mkdir -p ~/.google_workspace_mcp/credentials
cat > ~/.google_workspace_mcp/credentials/ryan@albertaskylights.ca.json << EOF
{
  "token": "",
  "refresh_token": "$GOOGLE_WORKSPACE_REFRESH_TOKEN",
  "token_uri": "https://oauth2.googleapis.com/token",
  "client_id": "$GOOGLE_OAUTH_CLIENT_ID",
  "client_secret": "$GOOGLE_OAUTH_CLIENT_SECRET",
  "scopes": ["https://www.googleapis.com/auth/drive", "https://www.googleapis.com/auth/documents", "https://www.googleapis.com/auth/spreadsheets", "https://www.googleapis.com/auth/gmail.modify", "https://www.googleapis.com/auth/calendar", "https://www.googleapis.com/auth/presentations"]
}
EOF
workspace-mcp --transport streamable-http --single-user --tool-tier extended
