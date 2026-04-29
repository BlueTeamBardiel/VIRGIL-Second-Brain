# OpenProject

## What it is
Think of it like a shared whiteboard where an entire organization pins every project, deadline, task, and team member — fully visible to anyone with access. OpenProject is an open-source web-based project management platform used by organizations to plan, track, and collaborate on work, hosting sensitive operational and personnel data in a self-hosted or cloud environment.

## Why it matters
In a 2023 attack scenario, a misconfigured OpenProject instance left exposed to the internet without authentication allowed a threat actor to enumerate active projects, team member names, email addresses, and internal timelines — providing perfect reconnaissance for a spear-phishing campaign. Because self-hosted deployments depend entirely on the administrator's security hygiene, unpatched versions or default credentials become high-value entry points into organizational intelligence.

## Key facts
- OpenProject is **self-hostable** (Ruby on Rails stack), meaning security responsibility falls entirely on the deploying organization — patch management is critical
- Default installations may expose **project names, user directories, and work packages** without proper access controls, constituting a significant information disclosure risk
- Versions prior to security patches have suffered **CVE-documented vulnerabilities** including XSS and privilege escalation, relevant to vulnerability management domains
- Integration with **LDAP/Active Directory** means a compromise of OpenProject credentials can pivot into broader directory-level access
- Classified under **OSINT attack surface**: exposed instances are indexable by Shodan and similar scanners, making them targets for automated reconnaissance

## Related concepts
[[Information Disclosure]] [[Attack Surface Management]] [[OSINT]] [[Privilege Escalation]] [[Patch Management]]