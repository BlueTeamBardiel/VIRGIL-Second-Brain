# iCalendar

## What it is
Think of it like a standardized shipping label for time — no matter which calendar app you use, everyone can read the same "package." iCalendar (RFC 5545) is a plain-text data format using the `.ics` file extension that allows calendar and scheduling information to be exchanged between applications and systems in a vendor-neutral way.

## Why it matters
Attackers have weaponized `.ics` files as phishing vectors — embedding malicious URLs inside calendar invites that auto-populate on victims' calendars, bypassing email filters entirely because the invite arrives as a legitimate scheduling request. This technique was notably used in OAuth phishing campaigns where clicking the calendar event link initiated unauthorized application authorization rather than joining a meeting.

## Key facts
- Uses a structured plain-text format with `BEGIN:VCALENDAR` / `END:VCALENDAR` delimiters; events are wrapped in `BEGIN:VEVENT` blocks
- Supports embedded URLs via the `URL:` property — a common field abused to redirect victims to phishing pages or malicious payloads
- `.ics` files can trigger automatic calendar population in Outlook, Google Calendar, and Apple Calendar with **no user approval required** in default configurations
- The format supports `ATTACH` properties, allowing embedded or linked file attachments — another delivery vector for malware
- Defined by RFC 5545 (1998, updated 2009); the related iTIP protocol (RFC 5546) governs how meeting invitations are sent and replied to

## Related concepts
[[Phishing]] [[Social Engineering]] [[Email Security]] [[OAuth Attacks]] [[File Format Exploitation]]