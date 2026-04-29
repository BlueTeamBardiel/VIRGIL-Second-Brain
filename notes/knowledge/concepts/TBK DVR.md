# TBK DVR

## What it is
Like a cheap padlock on a security guard's filing cabinet — the device meant to protect you becomes the vulnerability. TBK DVR (Digital Video Recorder) refers to a brand of network-connected surveillance recording devices that contain critical authentication bypass and command injection vulnerabilities. These embedded systems run minimal Linux-based firmware with exposed web management interfaces that rarely receive patches.

## Why it matters
In 2023, CISA issued alerts warning that threat actors were actively exploiting CVE-2018-9995, a five-year-old authentication bypass flaw in TBK DVR devices, to gain administrative access and harvest credentials. Attackers send a crafted cookie value to the device's web interface, completely bypassing login — no password required — then pivot into internal networks or conscript the device into botnets for DDoS campaigns.

## Key facts
- **CVE-2018-9995** allows unauthenticated attackers to retrieve admin credentials by sending a maliciously crafted HTTP cookie to the `/device.rsp?opt=usr&cmd=EncryptUserInfo` endpoint
- TBK DVRs are sold under multiple rebranded labels (Novo, CeNova, QSee, Pulnix, etc.), meaning the same vulnerable firmware exists across thousands of devices with different brand names
- Default credentials (`admin/admin`) are frequently unchanged by end users, compounding the authentication bypass risk
- These devices typically lack automatic update mechanisms, leaving CVEs unpatched for years after disclosure
- Exploitation requires no authentication and can be performed remotely over the internet if the management port (typically TCP 80/443) is internet-facing

## Related concepts
[[CVE Exploitation]] [[Default Credentials]] [[IoT Security]] [[Authentication Bypass]] [[Botnet Recruitment]]