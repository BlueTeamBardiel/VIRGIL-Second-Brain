# Windows Server 2016

## What it is
Think of it like a hardened bank vault with built-in security guards, compared to older server OS versions that were more like a regular office with a padlock. Windows Server 2016 is Microsoft's server operating system released in 2016, built on the Windows 10 kernel and introducing containerization, Nano Server deployments, and significant native security hardening features like Credential Guard and Device Guard.

## Why it matters
In a Pass-the-Hash attack, an adversary steals NTLM credential hashes from memory to authenticate without knowing the plaintext password. Windows Server 2016's **Credential Guard** isolates LSA secrets inside a hardware-backed virtualization container (VSM), making it significantly harder for tools like Mimikatz to extract credentials from LSASS — a direct, documented countermeasure to one of the most common lateral movement techniques in enterprise networks.

## Key facts
- **Credential Guard** uses Virtualization-Based Security (VBS) to isolate NTLM hashes and Kerberos tickets in a protected hypervisor enclave, defeating Pass-the-Hash and Pass-the-Ticket attacks
- **Device Guard** (now WDAC) enforces application whitelisting via code integrity policies, preventing unauthorized executables from running even with admin privileges
- Introduced **Shielded VMs** to protect Hyper-V virtual machines from compromised fabric administrators using BitLocker and TPM attestation
- **Just Enough Administration (JEA)** restricts PowerShell remoting sessions to specific cmdlets, limiting privilege escalation surface
- Supports **Windows Defender Advanced Threat Protection (ATP)** integration natively — relevant for CySA+ threat detection scenarios

## Related concepts
[[Credential Guard]] [[Pass-the-Hash Attack]] [[Virtualization-Based Security]] [[Just Enough Administration]] [[Windows Defender ATP]]