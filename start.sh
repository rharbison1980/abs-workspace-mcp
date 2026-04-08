#!/bin/bash
mkdir -p ~/.google_workspace_mcp/credentials

# Fetch a fresh access token on every container start
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
  "client_secret": "$GOOGLE_OAUTH_CLIENT_SECRET",
  "scopes": ["openid","https://www.googleapis.com/auth/userinfo.email","https://www.googleapis.com/auth/userinfo.profile","https://www.googleapis.com/auth/calendar","https://www.googleapis.com/auth/calendar.readonly","https://www.googleapis.com/auth/calendar.events","https://www.googleapis.com/auth/drive","https://www.googleapis.com/auth/drive.readonly","https://www.googleapis.com/auth/drive.file","https://www.googleapis.com/auth/documents","https://www.googleapis.com/auth/documents.readonly","https://www.googleapis.com/auth/gmail.readonly","https://www.googleapis.com/auth/gmail.send","https://www.googleapis.com/auth/gmail.compose","https://www.googleapis.com/auth/gmail.modify","https://www.googleapis.com/auth/gmail.labels","https://www.googleapis.com/auth/gmail.settings.basic","https://www.googleapis.com/auth/chat.messages.readonly","https://www.googleapis.com/auth/chat.messages","https://www.googleapis.com/auth/chat.spaces","https://www.googleapis.com/auth/chat.spaces.readonly","https://www.googleapis.com/auth/spreadsheets","https://www.googleapis.com/auth/spreadsheets.readonly","https://www.googleapis.com/auth/forms.body","https://www.googleapis.com/auth/forms.body.readonly","https://www.googleapis.com/auth/forms.responses.readonly","https://www.googleapis.com/auth/presentations","https://www.googleapis.com/auth/presentations.readonly","https://www.googleapis.com/auth/tasks","https://www.googleapis.com/auth/tasks.readonly","https://www.googleapis.com/auth/contacts","https://www.googleapis.com/auth/contacts.readonly","https://www.googleapis.com/auth/cse","https://www.googleapis.com/auth/script.projects","https://www.googleapis.com/auth/script.projects.readonly","https://www.googleapis.com/auth/script.deployments","https://www.googleapis.com/auth/script.deployments.readonly","https://www.googleapis.com/auth/script.processes","https://www.googleapis.com/auth/script.metrics"]
}
EOF

workspace-mcp --transport streamable-http --single-user --tool-tier extended
