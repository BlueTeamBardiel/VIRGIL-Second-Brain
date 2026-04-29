# FileItemDTO

## What it is
Like a shipping label stapled to a box — it describes what's inside without being the contents itself. A FileItemDTO (Data Transfer Object) is a lightweight data structure used to pass file metadata (name, size, path, type, permissions) between application layers or across API boundaries without exposing the underlying file system objects directly.

## Why it matters
In a 2021-style path traversal attack, an attacker manipulates a FileItemDTO's `filePath` field by injecting `../../etc/passwd` into an upload or download request. If the server blindly trusts the DTO's path value without sanitization, the application resolves outside the intended directory — leaking sensitive system files. Proper DTO validation acts as a gatekeeper that normalizes and rejects malicious path sequences before they reach the file system layer.

## Key facts
- **Path traversal vector**: FileItemDTOs that carry raw user-supplied path strings are a primary injection point; always canonicalize and validate against an allowed base directory.
- **Insecure Direct Object Reference (IDOR)**: Exposing sequential file IDs or predictable names in a FileItemDTO lets attackers enumerate and access unauthorized files by iterating values.
- **Over-sharing risk**: DTOs that include internal server paths, inode numbers, or permission bits in API responses leak reconnaissance data useful for privilege escalation.
- **Input validation location**: Validation must occur server-side on the DTO — client-side checks alone are trivially bypassed with tools like Burp Suite.
- **Serialization risk**: FileItemDTOs transmitted as JSON/XML can be manipulated mid-transit; always enforce schema validation and consider integrity signing for sensitive transfers.

## Related concepts
[[Path Traversal]] [[Insecure Direct Object Reference]] [[Input Validation]] [[API Security]] [[Serialization Attacks]]