# Windows Remote Management

## What it is
Think of WinRM like a universal TV remote that lets you control any compatible television in your house from one spot — except the "TV" is a Windows machine and the "remote" is a shell session. WinRM is Microsoft's implementation of the WS-Management protocol, enabling administrators to execute commands and manage systems remotely over HTTP (port 5985) or HTTPS (port 5986). It is the underlying transport for PowerShell Remoting and serves as the server-side component to the `winrm` command-line tool.

## Why it matters
Attackers who compromise domain credentials frequently use WinRM to move laterally across a network because it blends in with legitimate administrative traffic. In real incidents, tools like Evil-WinRM are used to establish interactive shells on target hosts, and because WinRM activity can be indistinguishable from normal sysadmin work, detection requires correlating Windows Event ID 4624 logon events with WinRM service logs (Microsoft-Windows-WinRM/Operational).

## Key facts
- Default ports: **5985** (HTTP/cleartext) and **5986** (HTTPS/encrypted); HTTPS is strongly preferred in production
- WinRM must be explicitly enabled via `winrm quickconfig` — it is **disabled by default** on workstations, enabled on Windows Server 2012+
- PowerShell Remoting (`Enter-PSSession`, `Invoke-Command`) uses WinRM as its transport layer
- Authentication options include Kerberos, NTLM, Certificate, and CredSSP — CredSSP delegates credentials and carries **double-hop risk**
- Defenders should restrict WinRM access using Windows Firewall rules, limit membership in the **Remote Management Users** group, and enable HTTPS-only listeners

## Related concepts
[[PowerShell Remoting]] [[Lateral Movement]] [[Pass-the-Hash]] [[Kerberos Authentication]] [[Windows Event Logs]]