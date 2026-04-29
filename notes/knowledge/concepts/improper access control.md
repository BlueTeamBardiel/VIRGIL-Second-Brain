# improper access control

## What it is
Imagine a hotel where the front desk hands out master keycards to anyone who asks nicely, without checking ID. Improper access control occurs when a system fails to correctly enforce who can read, write, or execute a resource — either by granting excessive permissions, skipping authentication checks, or trusting user-supplied input to determine access rights. It's the gap between *who should* access something and *who actually can*.

## Why it matters
In 2012, attackers exploited improper access control in Dropbox by reusing a stolen password hash to authenticate without the actual password — then accessed any user's files because internal folder permissions weren't independently verified. Defenders counter this by implementing least privilege, enforcing server-side authorization checks on every request, and never relying solely on client-side controls like hidden form fields or JavaScript.

## Key facts
- **OWASP ranks Broken Access Control as #1** in the 2021 Top 10, making it the most prevalent web application vulnerability class
- **Horizontal privilege escalation** means accessing *another user's* resources at the same privilege level (e.g., changing a URL parameter from `user=123` to `user=124`)
- **Vertical privilege escalation** means accessing resources *above* your privilege tier (e.g., a regular user reaching admin functions)
- **IDOR (Insecure Direct Object Reference)** is the most common implementation flaw — exposing internal database IDs directly in URLs without re-verifying authorization
- Access control must be enforced **server-side**; any client-side restriction (hidden fields, disabled buttons, URL obscurity) is trivially bypassed

## Related concepts
[[principle of least privilege]] [[insecure direct object reference]] [[privilege escalation]] [[authentication vs authorization]] [[broken access control]]