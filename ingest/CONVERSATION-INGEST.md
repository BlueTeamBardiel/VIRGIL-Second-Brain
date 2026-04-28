# Conversation Ingest

Save any Claude.ai conversation to your VIRGIL vault in one paste.

## What it does
Accepts pasted Claude.ai conversation text, summarizes it via local LLM or
Anthropic API, and saves a structured note to notes/conversations/.

Each note contains:
- Summary of what was worked on
- Key decisions made
- Tasks completed
- Tasks pending
- Key facts and configs

## Setup

### 1. Install Flask
  pip install flask --break-system-packages

### 2. Configure secrets
  mkdir -p ~/.config/virgil
  nano ~/.config/virgil/.env
  # Add:
  # ANTHROPIC_API_KEY="your-key-here"
  # SLACK_WEBHOOK_URL="your-webhook-here" (optional)
  chmod 600 ~/.config/virgil/.env

### 3. Start the service
  python3 ingest/conversation-ingest.py

Or install as a systemd service:
  sudo cp ingest/conversation-ingest.service /etc/systemd/system/
  sudo systemctl daemon-reload
  sudo systemctl enable conversation-ingest
  sudo systemctl start conversation-ingest

### 4. Access from any browser
  http://YOUR-HOST-IP:5002

## Usage
1. In Claude.ai press Ctrl+A then Ctrl+C
2. Open http://YOUR-HOST-IP:5002
3. Enter a session title
4. Paste with Ctrl+V
5. Hit Ingest Conversation
6. Check Slack for confirmation

## Notes
- Default port: 5002
- Max upload size: 50MB (handles even very long conversations)
- Notes saved to: notes/conversations/YYYY-MM-DD-HH-MM.md
- Service auto-starts on boot via systemd
