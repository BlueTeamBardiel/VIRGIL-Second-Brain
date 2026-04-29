# Missing Authorization

## What it is
Imagine a hotel where the front desk gives you a room key, but nobody ever checks whether your key actually matches the room you're trying to enter. Missing Authorization occurs when an application authenticates a user but fails to verify whether that authenticated user has *permission* to perform a specific action or access a specific resource. Authentication proves who you are; authorization proves what you're allowed to do — skipping the second check is the vulnerability.

## Why it matters
In 2019, a major U.S. healthcare API exposed patient records because it verified login credentials but never checked whether the requesting user owned the records being fetched. An attacker simply changed a patient ID parameter in the API call and harvested thousands of records — a classic Insecure Direct Object Reference (IDOR) attack rooted in missing authorization. Defense means enforcing server-side permission checks on every sensitive request, not trusting client-supplied identifiers alone.

## Key facts
- Missing Authorization is listed as **CWE-862** and maps directly to **OWASP API Security Top 10: API5 - Broken Function Level Authorization**
- It differs from **broken access control** (OWASP A01) only in granularity — missing authorization is the specific absence of a permission check, not a misconfigured one
- Common in REST APIs where developers enforce authentication via tokens but skip role/ownership validation on individual endpoints
- Horizontal privilege escalation (user accessing another user's data) and vertical privilege escalation (user accessing admin functions) both frequently stem from this flaw
- Remediation requires **deny-by-default** access control policies enforced server-side, paired with centralized authorization logic rather than scattered per-function checks

## Related concepts
[[Broken Access Control]] [[Insecure Direct Object Reference]] [[Privilege Escalation]] [[Authentication vs Authorization]] [[Least Privilege]]