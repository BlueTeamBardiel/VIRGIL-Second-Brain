# insecure direct object reference

## What it is
Imagine a hotel where room keys are numbered sequentially — if you have key #204, you simply try key #205 to walk into a stranger's room. Insecure Direct Object Reference (IDOR) is when a web application exposes internal implementation objects (database records, files, account IDs) directly in URLs or parameters without verifying the requesting user is actually authorized to access that specific object. The server hands out keys without checking whose name is on the reservation.

## Why it matters
In 2019, a researcher discovered that Facebook's ad platform used predictable numeric IDs in API calls — by incrementing the `account_id` parameter, an attacker could potentially read billing details belonging to other businesses. The defense is straightforward but often skipped: implement server-side authorization checks that verify the *current session's user* owns the requested resource, not just that they're logged in.

## Key facts
- IDOR is classified under **OWASP A01:2021 Broken Access Control** — the top web vulnerability category
- The vulnerability lives in **authorization logic**, not authentication — the attacker is a legitimate user abusing their privilege scope
- Common attack vectors: sequential integers (`/invoice?id=1042` → try `1041`), GUIDs (if leaked), and filename-based references (`/download?file=report_userA.pdf`)
- Mitigation requires **indirect reference maps** (random tokens mapping to real IDs server-side) or mandatory ownership checks before every data-fetch operation
- IDOR can expose **horizontal privilege escalation** (same-level user accessing peer data) or **vertical privilege escalation** (accessing admin-level resources)

## Related concepts
[[broken access control]] [[horizontal privilege escalation]] [[session management]] [[parameter tampering]]