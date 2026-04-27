---
domain: "attack-techniques"
tags: [supply-chain, third-party-risk, software-integrity, threat-actor, lateral-movement, persistence]
---
# Supply-Chain Attack

A **supply-chain attack** (also called a **value-chain attack** or **third-party attack**) targets the less-secure elements in the software, hardware, or vendor ecosystem that an organization relies on, rather than attacking the organization directly. By **compromising a trusted upstream provider**—such as a software vendor, build pipeline, or hardware manufacturer—attackers can distribute malicious code or backdoors to every downstream customer simultaneously. These attacks exploit the implicit trust relationships inherent in [[third-party software]], [[vendor management]], and modern [[software development lifecycle (SDLC)]] practices.

---

## Overview

Supply-chain attacks exist because modern organizations do not build everything they use from scratch. They rely on open-source libraries, commercial software vendors, managed service providers (MSPs), cloud platforms, and hardware manufacturers. Each link in this chain is a potential attack surface. An attacker who compromises a single well-positioned supplier can reach thousands of downstream victims simultaneously—achieving massive scale with a single intrusion.

The attack surface is enormous. The average enterprise application pulls in hundreds of third-party dependencies. A single npm package may be downloaded millions of times per week. A compromised update server for endpoint security software means every host running that product becomes instantly exploitable. This asymmetry—one successful upstream compromise yields access to thousands of targets—makes supply-chain attacks extraordinarily attractive to nation-state actors and sophisticated criminal groups alike.

Supply-chain attacks are not limited to software. **Hardware supply-chain attacks** involve implanting malicious chips or firmware into devices during manufacturing or shipping. **Firmware attacks** target the UEFI/BIOS layer, surviving OS reinstallation. **Managed Service Provider (MSP) attacks** use trusted remote-access tooling already deployed to customer environments. The common thread is exploitation of trust—the victim believes they are installing or using something legitimate because it came from a source they already authorized.

The **SolarWinds Orion** breach (2020) stands as the most widely studied modern supply-chain attack. Russian SVR threat actors (APT29/Cozy Bear) compromised SolarWinds' build environment, injecting the SUNBURST backdoor into signed Orion software updates delivered to approximately 18,000 customers, including multiple U.S. federal agencies. The **XZ Utils** backdoor (CVE-2024-3094) in early 2024 demonstrated how a patient threat actor can spend nearly two years socially engineering their way to commit access in an open-source project before inserting a malicious payload into a compression library present on virtually every Linux system. The **3CX** attack (2023) was itself a second-order supply-chain attack—3CX's desktop application was compromised because 3CX developers used a trojanized version of the Trading Technologies X_TRADER software.

---

## How It Works

Supply-chain attacks vary significantly depending on the targeted link in the chain, but share a common attack lifecycle:

### Phase 1: Target Selection and Reconnaissance

The attacker identifies a supplier with broad deployment across target organizations. This might mean:
- A commercial software vendor whose product is deployed on thousands of enterprise endpoints
- A popular open-source library with millions of weekly downloads (e.g., `event-stream`, `colors`, `node-ipc`)
- An MSP with administrative access to hundreds of client networks
- A hardware ODM (Original Design Manufacturer) supplying components to multiple vendors

### Phase 2: Compromise the Upstream Entity

**Software build pipeline compromise (SolarWinds-style):**
```
Attacker gains initial access → moves laterally to build server
         → injects malicious code into source before compilation
         → code is compiled and digitally signed by vendor's legitimate cert
         → signed malicious binary is distributed via vendor's update CDN
```

The injected code may be extremely subtle. The SUNBURST implant in SolarWinds dormant for up to two weeks after installation, checking for Active Directory domains and security tools before activating, specifically to evade sandbox analysis.

**Dependency confusion / typosquatting:**
Attackers publish malicious packages to public registries (npm, PyPI, RubyGems) with names that either:
1. Match internal private package names (dependency confusion—private registries may pull the public version instead)
2. Are typos of legitimate popular packages (`requeests` vs `requests`, `colourama` vs `colorama`)

```bash
# Attacker publishes a malicious package named to match an internal package
# When pip or npm resolves dependencies, public registry version (higher version number) wins
pip install companyinternal-utils   # fetches attacker's public package instead of private one
```

**Compromising a developer account:**
```
Phishing → credential theft → MFA bypass
         → attacker gains commit/publish rights to legitimate project
         → malicious code submitted as innocent-looking PR or patch
         → merged and published to package registry
```

**MSP/RMM tool compromise:**
MSPs use Remote Monitoring and Management (RMM) tools such as Kaseya VSA, ConnectWise, or SolarWinds N-Central to manage client endpoints. In the **Kaseya VSA** attack (2021, REvil ransomware), attackers exploited a zero-day in the VSA on-premises server:
```
CVE-2021-30116 (credential leak) + CVE-2021-30119 (XSS) + CVE-2021-30120 (2FA bypass)
         → Attacker uploads malicious agent procedure via VSA
         → VSA distributes payload to all managed endpoints as trusted update
         → REvil ransomware deployed to 1,500+ businesses
```

### Phase 3: Payload Delivery and Execution

Once distributed, the payload executes in the context of the trusted application—often with elevated privileges. The malicious update may:
- Establish a [[command-and-control (C2)]] channel (SUNBURST used HTTP/HTTPS to `avsvmcloud[.]com`)
- Drop a secondary implant (SUNBURST dropped TEARDROP/RAINDROP loaders)
- Exfiltrate credentials and data
- Deploy ransomware across all managed endpoints

### Phase 4: Lateral Movement and Persistence

Because the initial foothold is on a trusted, highly-privileged system (security tool, IT management agent, developer workstation), attackers can move laterally with minimal detection:
```powershell
# SUNBURST enumerated AD using standard LDAP queries—indistinguishable from normal Orion activity
[System.DirectoryServices.ActiveDirectory.Domain]::GetCurrentDomain()
```

### Hardware Supply Chain

Hardware implants (e.g., alleged Bloomberg "Big Hack" scenario involving SuperMicro servers) involve inserting rogue chips or modifying existing chips during PCB manufacturing. These implants can:
- Intercept BMC (Baseboard Management Controller) communications
- Inject code during firmware updates
- Create persistent backdoors invisible to software-level security tools

---

## Key Concepts

- **Build Pipeline Integrity**: The security of the end-to-end process by which source code is compiled, packaged, and distributed. A compromised CI/CD pipeline (Jenkins, GitHub Actions, TeamCity) can inject malicious code into otherwise legitimate software without altering the visible source repository.

- **Software Bill of Materials (SBOM)**: A formal, machine-readable inventory of all software components, libraries, and dependencies included in an application. SBOMs enable rapid identification of vulnerable or compromised components. Mandated for federal software procurement by U.S. Executive Order 14028 (2021).

- **Dependency Confusion Attack**: An attack technique (demonstrated by Alex Birsan in 2021) where a publicly published package with the same name as a private internal package is fetched preferentially by package managers due to version number resolution logic. Affects npm, pip, RubyGems, and others.

- **Typosquatting**: Registration of package names that are common misspellings or near-homophones of popular legitimate packages, hoping developers accidentally install the malicious version. Examples: `djanga` (Django), `colourama` (colorama).

- **Code Signing**: The use of [[PKI]] certificates to digitally sign compiled software, assuring recipients of authorship and integrity. Supply-chain attacks often defeat this control by compromising the signing infrastructure itself, producing legitimately signed malicious binaries.

- **Trusted Execution Environment / Attestation**: Hardware-rooted mechanisms (Intel TXT, AMD SEV, TPM-based remote attestation) used to verify that software has not been tampered with prior to execution. Part of [[Secure Boot]] and [[Zero Trust Architecture]] implementations.

- **Watering Hole via Update Mechanism**: Using a vendor's own legitimate update distribution infrastructure (CDN, update server) to deliver malicious payloads, bypassing allowlist controls that trust traffic from that vendor's domains and IPs.

---

## Exam Relevance

**Security+ SY0-701 Domain Mapping:**
- Domain 2.0: Threats, Vulnerabilities, and Mitigations — supply chain attacks are explicitly listed
- Domain 5.0: Security Program Management — vendor risk management, third-party assessments

**Key exam patterns and tips:**

1. **Know the terminology**: The exam uses "supply chain attack," "third-party risk," and may describe scenarios involving MSPs, software updates, or open-source libraries. Recognize all three framings as the same category.

2. **SolarWinds is the canonical example**: Expect scenario questions describing a signed software update from a trusted vendor that contains malicious code. The correct answer framing involves supply-chain attack, not phishing or drive-by download.

3. **Mitigations the exam loves**:
   - SBOM (Software Bill of Materials) — know this acronym
   - Code signing — necessary but not sufficient (SolarWinds was signed!)
   - Vendor due diligence / third-party risk assessments
   - Principle of least privilege for vendor/MSP access

4. **Gotcha — Code Signing Does NOT Prevent This**: A common exam trap presents a scenario where software was code-signed and asks why it was still malicious. The answer: the build environment was compromised *before* signing, so the signature is legitimate.

5. **Gotcha — MSP Attacks Are Supply Chain Attacks**: If a scenario describes an attacker using an MSP's RMM tool to deploy ransomware to all the MSP's clients, that is a supply-chain attack, not simply a remote access attack.

6. **Vendor Risk Management controls**: Know that contracts (right-to-audit clauses), questionnaires (SIG, CAIQ), and third-party certifications (SOC 2, ISO 27001) are the business/policy controls associated with supply-chain risk reduction.

---

## Security Implications

### Real-World Incidents and CVEs

| Incident | Year | Vector | Impact |
|---|---|---|---|
| SolarWinds SUNBURST | 2020 | Trojanized Orion update | ~18,000 orgs, US govt agencies; CVE-2020-10148 |
| Kaseya VSA / REvil | 2021 | VSA zero-days → RMM abuse | 1,500+ SMBs, ransomware; CVE-2021-30116/30119/30120 |
| XZ Utils Backdoor | 2024 | Malicious maintainer commit | SSH daemon RCE on affected Linux distros; CVE-2024-3094 |
| 3CX Desktop App | 2023 | Trojanized dependency (X_TRADER) | Enterprise VoIP client, 2nd-order supply chain |
| event-stream (npm) | 2018 | Malicious maintainer takeover | Targeted Bitcoin wallet theft via compromised npm package |
| ASUS Live Update | 2019 | Trojanized update server | 500K+ ASUS machines; Operation ShadowHammer |
| CCleaner | 2017 | Compromised build system | 2.27M users received backdoored installer |
| NotPetya (M.E.Doc) | 2017 | Trojanized accounting software update | $10B+ damages; Ukrainian software widely used |

### Attack Vectors
- **Compromised CI/CD pipelines**: Jenkins, GitHub Actions, CircleCI all have had significant security incidents
- **Package registry account takeover**: Weak credentials on npm, PyPI maintainer accounts
- **Open source project abandonment**: Legitimate projects transferred to new maintainers who inject malicious code
- **Hardware tampering during shipping**: Interdiction of hardware packages by intelligence agencies

### Detection Challenges
Supply-chain attacks are extraordinarily difficult to detect because:
- Traffic and binaries appear legitimate (signed, from expected sources)
- Behavior mimics normal application activity (SUNBURST used the Orion API framework for its C2 traffic)
- Dwell time before activation (SUNBURST waited 12-14 days minimum)
- Endpoint security tools may be disabled by the malicious payload before detection

---

## Defensive Measures

### Software Integrity and SBOM
```bash
# Generate SBOM with Syft (Anchore)
syft dir:/path/to/application -o spdx-json > sbom.json

# Scan SBOM for known vulnerabilities with Grype
grype sbom:./sbom.json

# Verify package integrity against known-good hashes
pip download requests==2.31.0
sha256sum requests-2.31.0-py3-none-any.whl
# Compare against published hash on PyPI
```

### Dependency Verification
```bash
# npm: use lockfiles and audit
npm ci          # install from package-lock.json exactly, no resolution
npm audit       # check for known vulnerabilities

# pip: pin versions and verify hashes
pip install --require-hashes -r requirements.txt
# requirements.txt with hashes:
# requests==2.31.0 \
#   --hash=sha256:58cd2187423d9a68...

# Verify git commit signing
git log --show-signature
git config --global commit.gpgsign true
```

### CI/CD Pipeline Hardening
```yaml
# GitHub Actions: pin actions to specific commit SHA, not mutable tags
# BAD:
- uses: actions/checkout@v3

# GOOD (commit SHA pinning prevents tag hijacking):
- uses: actions/checkout@8ade135a41bc03ea155e62e844d188df1ea18608

# Add SLSA provenance generation
- uses: slsa-framework/slsa-github-generator/.github/workflows/generator_generic_slsa3.yml@v1.9.0
```

### Vendor and MSP Risk Controls
1. **Vendor due diligence**: Require SOC 2 Type II reports, ISO 27001 certification, or CAIQ questionnaire completion
2. **Right-to-audit clauses**: Include in contracts with critical software vendors
3. **Least privilege for MSP access**: Use tiered access models; MSP tools should not have domain admin rights
4. **Network segmentation**: MSP management networks should be isolated from production
5. **Privileged Access Workstations (PAW)**: Dedicated hardened systems for admin functions; MSP agents cannot be used from general-purpose machines

### Runtime Detection
```bash
# Use file integrity monitoring (FIM) on critical binaries
# AIDE (Advanced Intrusion Detection Environment)
aide --init    # create baseline database
aide --check   # compare current state to baseline

# Monitor for unexpected network connections from trusted applications
# Zeek/Bro: alert on SolarWinds Orion connecting to unexpected external IPs
# auditd: monitor execve syscalls from update processes
auditctl -a always,exit -F arch=b64 -S execve -F uid=0 -k root_commands
```

### Supply Chain Security Frameworks
- **SLSA (Supply chain Levels for Software Artifacts)**: Google-originated framework with four levels of build integrity guarantees
- **NIST SP 800-161**: Cybersecurity Supply Chain Risk Management Practices for Systems and Organizations
- **in-toto**: A framework for securing the software supply chain by defining and verifying steps in the build process
- **Sigstore/Cosign**: Keyless signing and transparency log for container images and artifacts
  ```bash
  cosign verify --certificate-identity developer@example.com \
    --certificate-oidc-issuer https://accounts.google.com \
    gcr.io/myproject/myimage:latest
  ```

---

## Lab / Hands-On

### Lab 1: Simulate Dependency Confusion Detection

```bash
# Set up a local PyPI mirror with devpi
pip install devpi-server devpi-client
devpi-server --start --init
devpi use http