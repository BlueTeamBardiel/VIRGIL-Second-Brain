# broken access control

## What it is
Imagine a hotel where any guest can walk into any room because the master key system ignores room numbers entirely — that's broken access control. It occurs when an application fails to enforce restrictions on what authenticated users are allowed to do or access, allowing them to act outside their intended permissions. This is distinct from authentication failures; the user is *known*, but the system doesn't properly limit what they can *touch*.

## Why it matters
In 2019, researchers found that a major US health insurer exposed millions of patient records simply by incrementing an ID number in the URL — no special privileges required, just curiosity and arithmetic. This is a classic **Insecure Direct Object Reference (IDOR)** attack, a sub-type of broken access control. A proper defense would enforce server-side authorization checks verifying the requesting user *owns* the object before returning it, regardless of URL manipulation.

## Key facts
- Broken access control is the **#1 vulnerability in the OWASP Top 10 (2021)**, up from #5 in 2017, reflecting how widespread and dangerous it is.
- **IDOR (Insecure Direct Object Reference)** is the most common form — manipulating a reference (URL, parameter, cookie) to access unauthorized objects.
- **Horizontal privilege escalation**: accessing another user's data at the *same* privilege level. **Vertical privilege escalation**: gaining higher-privilege functions (e.g., becoming admin).
- Mitigation requires **server-side enforcement** — client-side hiding of buttons or menu items is not access control.
- The **principle of least privilege** and **deny-by-default** policies are the foundational defensive controls against this class of vulnerability.

## Related concepts
[[privilege escalation]] [[insecure direct object reference]] [[principle of least privilege]] [[authentication vs authorization]] [[OWASP Top 10]]