Generate a dense handoff summary for continuing this session in a new chat.

Read the current session context and produce a summary under 500 words with
these sections:

**What we were working on:**
(2-3 sentences describing the project and current task)

**Decisions made:**
(bullet list — every architectural or process decision and the reason why)

**Completed this session:**
(bullet list — everything finished, with specifics: file names, commit hashes,
commands that worked)

**In progress / current state:**
(bullet list — what's partially done, current status, what step we're on)

**Exact next steps:**
(numbered list — what to do next in order, specific enough to execute without
additional context)

**Key facts to remember:**
(bullet list — IPs, file paths, hostnames, versions, config values, anything
that would be hard to reconstruct)

End with this line exactly:
"Paste this into a new Claude.ai chat starting with: 'Continuing from a
previous session. Full context:'"
