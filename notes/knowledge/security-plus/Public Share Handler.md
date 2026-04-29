# Public Share Handler

## What it is
Think of it like a hotel lobby where anyone can walk in and grab brochures from the rack — no key card required. A Public Share Handler is a system component or service that manages access to network-shared resources (folders, files, printers) without requiring authentication, allowing unauthenticated or guest-level users to enumerate and retrieve shared content.

## Why it matters
In a classic lateral movement scenario, an attacker who gains initial foothold on a network runs a tool like `enum4linux` or `smbclient` to discover misconfigured public SMB shares. If the Public Share Handler is permissive — for example, allowing anonymous access to a SYSVOL-adjacent share — an attacker can harvest credentials, scripts, or configuration files without ever cracking a password.

## Key facts
- Windows SMB null sessions historically allowed unauthenticated enumeration of shares; this is controlled by the `RestrictAnonymous` registry key (`HKLM\SYSTEM\CurrentControlSet\Control\Lsa`)
- Public share exposure is a common finding in CIS Benchmark audits and maps to **MITRE ATT&CK T1135** (Network Share Discovery)
- Anonymous FTP shares are another common Public Share Handler vector — misconfigured servers allow `anonymous` / any-password login by default
- The principle of **least privilege** dictates that no share should be publicly accessible unless explicitly required and documented
- Tools like **Nessus**, **Nmap** (`--script smb-enum-shares`), and **Metasploit** actively probe for open share handlers during vulnerability assessments

## Related concepts
[[SMB Enumeration]] [[Null Session Attack]] [[Least Privilege Principle]] [[Network Share Discovery]] [[Anonymous FTP]]