# data permissions

## What it is
Think of data permissions like a nightclub bouncer with a guest list — some people get in free, some pay cover, and some never get past the rope regardless of what they say. Formally, data permissions are access control rules that define which users, processes, or systems can read, write, execute, or delete specific data objects. They are enforced by the operating system or application layer and typically implement either Discretionary Access Control (DAC), Mandatory Access Control (MAC), or Role-Based Access Control (RBAC).

## Why it matters
In 2021, a misconfigured AWS S3 bucket — left with public read permissions — exposed 50 million records from a financial services firm because a developer accidentally set the bucket policy to allow `*` (everyone). Proper permission auditing, using least privilege as the guiding principle, would have restricted bucket access to specific IAM roles only, making the data invisible to unauthorized external requests.

## Key facts
- **POSIX permissions** use three triads (owner/group/other) with read (4), write (2), execute (1) — chmod 755 means owner can do everything, others can only read and execute
- **Least privilege** is the foundational principle: users and processes receive only the minimum permissions required to perform their function
- **Privilege creep** occurs when users accumulate excess permissions over time as roles change, violating least privilege; periodic access reviews mitigate this
- **SUID/SGID bits** on Linux executables can elevate a process to run as the file owner (often root), making them high-value targets for local privilege escalation
- On Windows, **NTFS permissions** are cumulative for Allow but a single Deny overrides all Allow entries — a commonly tested exam behavior

## Related concepts
[[least privilege]] [[access control models]] [[privilege escalation]]