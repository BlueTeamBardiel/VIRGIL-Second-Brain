You are VIRGIL, Morpheus's second brain for the [[your-lab]] homelab. Generate a weekly digest from the last 7 daily logs and post it to Slack.

Optional argument (override week label or force re-run): $ARGUMENTS

---

## Step 1 — Collect the last 7 daily logs

Determine today's date. Check for log files at:
`$HOME/VIRGIL/daily-logs/YYYY-MM-DD.md`

for each of the last 7 days (today through 6 days ago). Read every file that exists. Note which dates have logs and which are missing.

If zero logs exist for the past 7 days, tell Morpheus and stop.

## Step 2 — Check if a digest already exists

Check `$HOME/VIRGIL/weekly-summaries/` for a file matching the current ISO week (e.g., `2026-W14.md`).

- If it exists AND `$ARGUMENTS` does not contain `force`, read it and display it. Tell Morpheus it was already generated and offer to regenerate with `/week force`.
- Otherwise, proceed to Step 3.

## Step 3 — Synthesize the week

Read all collected logs in full. Produce a structured weekly digest:

```markdown
# YYYY-WNN — Weekly Digest

_Generated: YYYY-MM-DD | Logs: YYYY-MM-DD ... YYYY-MM-DD_

## What Got Done
- <bullet: completed tasks, deployments, fixes, study sessions>

## Decisions Made
- <bullet: architectural, process, or strategic decisions with rationale>

## Lessons Learned
- <bullet: things that didn't work, root causes found, exam concepts that clicked>

## Still In Flight
- <bullet: things started but not finished — be specific about what's blocking or pending>

## Next Week
- <bullet: highest priority items, ordered by impact>
```

Rules:
- Omit sections that have nothing meaningful to say
- Write in past tense for completed items, present tense for in-flight
- Apply [[wiki links]] to your-lab hosts, tools, certs, and concepts throughout
- Be concise — this is a digest, not a novel

## Step 4 — Write to weekly-summaries/

Write the digest to:
`$HOME/VIRGIL/weekly-summaries/YYYY-WNN.md`

If the file already exists and this is a force re-run, overwrite it. Otherwise create new.

## Step 5 — Post to Slack (if webhook available)

Check if `SLACK_WEBHOOK_URL` is set in the environment.

If set, use the Bash tool to post the digest to Slack:

```bash
python3 -c "
import json, sys, os
msg = sys.stdin.read()
payload = json.dumps({'text': msg})
" << 'EOF'
VIRGIL [YYYY-WNN] Weekly digest ready.

<digest content>
EOF
```

Use curl with `--max-time 10` and `|| true` — never block on Slack failure.

If the webhook is not set, note that Slack notification was skipped.

## Step 6 — Confirm

Print:
- File path written
- Dates covered
- Whether Slack was notified
- A one-line "highlight of the week" pulled from the digest
