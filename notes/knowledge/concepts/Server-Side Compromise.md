# Server-Side Compromise

## What it is
Like a burglar who breaks into the post office itself rather than stealing mail from individual mailboxes, a server-side compromise targets the infrastructure that *serves* data rather than the clients who receive it. It occurs when an attacker gains unauthorized access to a server by exploiting vulnerabilities in server software, misconfigurations, or unpatched services — giving them control over every user that server touches.

## Why it matters
In the 2017 Equifax breach, attackers exploited an unpatched Apache Struts vulnerability (CVE-2017-5638) on a public-facing web server, ultimately exfiltrating 147 million records. No individual user could have prevented this — the server itself was the attack surface. This illustrates why server hardening and patch management are foundational controls, not optional hygiene.

## Key facts
- **Common attack vectors** include unpatched CVEs, SQL injection, remote code execution (RCE), insecure deserialization, and server misconfigurations (e.g., exposed admin panels, default credentials)
- **Privilege escalation** frequently follows initial server access — attackers land with limited service-account privileges, then move to root/SYSTEM
- **Indicators of compromise (IoCs)** include unexpected outbound connections, new admin accounts, modified web shells (e.g., `.php` or `.aspx` backdoors), and anomalous cron jobs
- **Watering hole attacks** combine server-side compromise with client targeting — attackers compromise a legitimate server to push malware to visiting users
- On Security+/CySA+, server-side compromise is contrasted with **client-side attacks** — knowing which side the vulnerability lives on determines the correct defensive control (WAF vs. endpoint protection)

## Related concepts
[[Remote Code Execution]] [[SQL Injection]] [[Privilege Escalation]] [[Web Application Firewall]] [[Patch Management]]