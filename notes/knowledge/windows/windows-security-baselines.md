# Windows Security Baselines

Microsoft‑recommended configuration settings that explain security implications for Windows and Windows Server environments. Security baselines aggregate expert knowledge from Microsoft engineering teams, partners, and customers to provide industry‑standard, well‑tested configurations.

## What Is It? (Feynman Version)

Imagine a car’s factory‑installed safety package: airbags, seat belts, crash‑detection. Windows Security Baselines are that package for computers—pre‑chosen, tested settings that put the system in a defensible state without you having to decide each individual rule.

## Why Does It Exist?

Back when Windows shipped, administrators had to hunt through 3,000+ Group Policy options to harden a machine. Mistakes cost money, data, and sometimes jobs. Security Baselines were created to reduce that hunting, standardize defenses, and keep pace with new threats. They let a devops team focus on application logic instead of patching policy slugs.

## How It Works (Under The Hood)

1. **Baseline Package** – Microsoft publishes a ZIP containing a Group Policy Object (GPO) backup, a PowerShell script, and a reference file.  
2. **Import** – The script runs `Import-GPO –Path` or `Import-GPO -BackupFile` into the domain’s Group Policy Management Console (GPMC).  
3. **Link** – The new GPO is linked to the desired Organizational Units (OUs).  
4. **Policy Application** – At computer startup or policy refresh, the Windows Policy Engine reads the GPO entries, writes registry keys, adjusts local security policy, or updates Windows Features.  
5. **Audit** – The same script can generate a compliance report by comparing the live machine state against the baseline registry snapshot.

## What Breaks When It Goes Wrong?

- **Mis‑linking** a GPO to the wrong OU: thousands of users may inherit wrong settings, causing service outages.  
- **Partial application** (e.g., Group Policy Client side extension failure): critical protections may be missing while the rest of the system appears compliant.  
- **Baseline drift**: if admins manually tweak settings after import, the machine no longer matches the baseline, and attackers can exploit unhardened paths.  
- **Compliance violations**: auditors report non‑conformance, leading to fines, legal exposure, or loss of customer trust.

## Lab Relevance

| Step | Command / Procedure | What to Watch For |
|------|---------------------|-------------------|
| **Deploy** | `powershell -File .\Import-Baseline.ps1 -Domain "contoso.com" -OU "Marketing"` | Confirm the GPO appears in GPMC and is linked correctly. |
| **Verify** | `gpresult /SCOPE:computer /R` | Ensure the baseline GPO is listed and all settings applied. |
| **Audit** | `.\Generate-Audit.ps1` | Look for any settings that differ from the baseline snapshot; note registry keys, local policies. |
| **Simulate Failure** | Disable `User Account Control` setting manually, then run audit. | Observe audit flagging the deviation; understand impact on security. |
| **Rollback** | `Restore-GPO –Name "Baseline - Windows 10 Home"` | Ensure the machine reverts to baseline state without lingering custom changes. |

**Tip:** Use a YOUR-LAB container image with the baseline package pre‑loaded to iterate quickly—import, audit, tweak, repeat.

## What are Security Baselines?

A security baseline is a group of [[Microsoft]]‑recommended configuration settings that explains their security implication. These settings are based on feedback from Microsoft security engineering teams, product groups, partners, and customers.

## Why Security Baselines Matter

- **Complexity reduction**: Windows 10 alone has over 3,000 [[Group Policy]] settings plus 1,800+ [[Internet Explorer 11]] settings; only a subset are security‑related
- **Expert guidance**: Eliminates need to individually determine security implications and appropriate values for each setting
- **Threat landscape alignment**: Enables rapid updates to address evolving security threats
- **Cost efficiency**: Industry‑standard configurations increase flexibility and reduce implementation costs

## Supported Editions & Licensing

### Supported Windows Editions
- Windows Pro ✅
- Windows Enterprise ✅
- Windows Pro Education/SE ✅
- Windows Education ✅
- Windows Server 2022 ✅
- Windows Server 2019 ✅
- Windows Server 2016 ✅

### License Entitlements
- Windows Pro/Pro Education/SE
- Windows Enterprise E3
- Windows Enterprise E5
- Windows Education A3
- Windows Education A5

## Key Principles

Microsoft recommends implementing well‑known, proven baseline configurations rather than creating custom baselines. Baselines are provided in consumable formats such as [[Group Policy Object]] backups.

## Tags

#windows-security #baseline #configuration #group-policy #microsoft-security

---
_Ingested: 2026-04-15 20:19 | Source: https://learn.microsoft.com/en-us/windows/security/threat-protection/windows-security-configuration-framework/windows-security-baselines_