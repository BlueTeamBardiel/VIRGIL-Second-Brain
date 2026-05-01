# aclcontrol

## What it is
Think of it like a bouncer's clipboard at an exclusive club — only names on the list get through, and the bouncer enforces *who wrote* the list. `aclcontrol` is a command-line utility on some Unix/Linux systems used to manage and enforce Access Control Lists (ACLs), which extend traditional DAC permissions by allowing granular, per-user or per-group access rules on files and directories beyond the standard owner/group/other model.

## Why it matters
An attacker who gains a low-privileged shell on a Linux server might exploit misconfigured ACLs to read `/etc/shadow` or write to a cron directory even when standard `rwx` permissions appear restrictive. A defender using `aclcontrol` or `getfacl`/`setfacl` tooling can audit these extended permissions to detect privilege escalation vectors — a check commonly missed in standard permission audits because `ls -la` does not reveal ACL entries.

## Key facts
- ACLs extend the POSIX permission model; a `+` sign in `ls -l` output (e.g., `-rw-r--r--+`) signals that an ACL entry exists on that file.
- `aclcontrol` is associated with AIX and some BSD environments; Linux systems predominantly use `setfacl` and `getfacl` from the `acl` package.
- ACL entries follow the format `user:<username>:<permissions>` or `group:<groupname>:<permissions>`, enabling access for specific principals without changing file ownership.
- Mask entries in ACLs define the *maximum effective permissions* for named users and groups — a critical concept for understanding why setting an ACL doesn't always grant expected access.
- Failure to audit ACLs is a common finding in CIS Benchmark reviews and can represent a compliance gap under frameworks like PCI-DSS or HIPAA.

## Related concepts
[[Access Control Lists]] [[DAC - Discretionary Access Control]] [[Linux File Permissions]] [[setfacl]] [[Privilege Escalation]]
