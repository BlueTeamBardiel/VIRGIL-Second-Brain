---
domain: "malware"
tags: [malware, adware, pup, browser-security, endpoint-security]
---

# Adware

**Adware** (advertising-supported software) is a class of **[[Malware]]** that automatically displays, downloads, or redirects users toward unwanted advertisements to generate revenue for its author. While some adware is legally bundled with freeware as a monetization model, malicious variants blur the line with **[[Spyware]]** by tracking user behavior, hijacking browsers, and evading removal — behaviors that often qualify them as **[[Potentially Unwanted Programs (PUPs)]]**.

---

## Overview

Adware emerged in the late 1990s as a legitimate business model: software developers distributed free applications subsidized by in-app advertising. Early examples included the Gator/Claria toolbar, Bonzi Buddy, and the original Kazaa client, which displayed banner ads during use. Over time, the model was abused by distributors who bundled intrusive ad modules into installers without clear consent, leading to the modern negative connotation.

Modern adware spans a spectrum. At the benign end sit ad-supported mobile apps and free services that disclose advertising in their EULAs. At the malicious end sit **browser hijackers**, **coupon injectors**, and **man-in-the-browser** frameworks that modify search results, inject ads into unrelated web pages, and exfiltrate browsing telemetry. Notorious families include **Fireball** (Rafotech, ~250 million infections in 2017), **DollarRevenue**, **Superfish** (preinstalled on Lenovo laptops in 2014–2015, which broke **[[TLS]]** trust by installing a rogue root CA), and **Adups** firmware on low-cost Android devices.

Adware is economically motivated: threat actors earn money through **pay-per-click (PPC)** fraud, **affiliate hijacking** (rewriting Amazon/eBay referral tags), impression fraud, and selling aggregated browsing data to ad networks. Because payouts occur per-install or per-click, adware authors prioritize volume distribution through **bundleware**, **malvertising**, cracked software, and **fake updates** (e.g., the SocGholish "update your browser" campaign).

From a regulatory standpoint, jurisdictions like the U.S. (FTC Act Section 5), the EU (**GDPR**, ePrivacy Directive), and California (CCPA) have pursued adware vendors for deceptive practices and unlawful data collection. Nonetheless, adware remains one of the most prevalent threat categories encountered on consumer endpoints.

## How It Works

Adware typically follows a predictable lifecycle: **delivery → installation → persistence → monetization → evasion**.

**1. Delivery.** Common vectors include:
- **Bundleware installers** using frameworks like InstallCore, OpenCandy, or Amonetize that offer "recommended" optional software pre-checked during setup.
- **Malvertising** — compromised or malicious ad-network creatives redirect users via JavaScript to exploit kits or fake download pages.
- **Cracked software** and torrents from sites hosting keygens laced with adware droppers.
- **Browser extensions** published to the Chrome Web Store or Firefox Add-ons that request broad `<all_urls>` permissions.
- **Mobile app stores**, especially third-party Android markets, distributing repackaged apps with SDKs like HummingBad or CopyCat.

**2. Installation.** On Windows, adware commonly installs to `%APPDATA%`, `%LOCALAPPDATA%`, or `%ProgramData%` to avoid UAC prompts. It registers a Windows service, scheduled task, or Run key:

```
HKCU\Software\Microsoft\Windows\CurrentVersion\Run
HKLM\Software\Microsoft\Windows\CurrentVersion\Run
schtasks /create /tn "UpdaterSvc" /tr "C:\ProgramData\ad.exe" /sc onlogon
```

**3. Browser manipulation.** Adware modifies the browser by:
- Installing a browser extension or NPAPI/PPAPI plugin.
- Changing the default search provider and homepage via registry keys (`HKCU\Software\Microsoft\Internet Explorer\Main`) or Chrome's `Preferences` JSON.
- Setting a **proxy auto-config (PAC)** URL to route traffic through an ad-injection server.
- Installing a **root certificate** to perform **[[TLS]] interception** (as Superfish did with `komodia.com`), enabling HTTPS ad injection.
- Modifying the `hosts` file to redirect search engines.

**4. Monetization.** Once resident, the adware:
- Injects `<script>` and `<iframe>` tags into rendered HTML.
- Rewrites DOM `<a>` tags to affiliate URLs.
- Generates background HTTP requests to click-fraud networks.
- Displays pop-ups, pop-unders, and desktop notifications via the Web Push API.

**5. Persistence and evasion.** Techniques include watchdog processes that respawn killed siblings, packed binaries to defeat AV signatures, code signing with shell-company certificates, randomized filenames/paths, and anti-uninstall tricks (e.g., reinstalling itself from a hidden scheduled task).

## Key Concepts

- **Bundleware** — Legitimate-looking installers that silently install secondary adware payloads, often exploiting confusing UI ("Decline" vs. "Next" buttons).
- **Browser Hijacker** — A subclass of adware that forcibly alters browser settings (homepage, search engine, new-tab page) and resists reversal.
- **Malvertising** — Delivery of malware through online advertising networks, often leveraging **[[Exploit Kits]]** or social engineering lures.
- **Potentially Unwanted Program (PUP/PUA)** — A classification used by AV vendors for software that is not strictly malicious but exhibits unwanted behavior; adware is the largest PUP category.
- **Click Fraud** — Automated generation of ad clicks to steal revenue from advertisers; a primary monetization path for adware.
- **Affiliate Hijacking** — Rewriting referral/affiliate IDs in shopping URLs so the attacker receives commissions the user or site operator would earn.
- **Man-in-the-Browser (MitB)** — Extension- or DLL-based interception of browser content, used by both adware (for injection) and banking Trojans.

## Exam Relevance

For **Security+ SY0-701**, adware appears under **Domain 2.4 (Malware types)**. Expect to:

- Distinguish adware from **[[Spyware]]** (adware shows ads; spyware covertly collects data — though overlap is heavy) and from **[[Rootkit]]s** or **[[Ransomware]]**.
- Recognize the term **PUP/PUA** as the enterprise classification.
- Identify **browser redirection**, **pop-ups**, and **changed homepage** as classic adware indicators in scenario questions.
- Know that **bundled freeware** and **drive-by downloads** are common delivery mechanisms.
- Understand that adware is often addressed by **[[EDR]]** and anti-malware tools in their PUP detection tier (sometimes disabled by default — a gotcha).

Common question pattern: "A user reports the browser keeps redirecting to unfamiliar shopping sites and new tabs open with advertisements. Which malware type is MOST likely responsible?" — Answer: **Adware**.

## Security Implications

Although often dismissed as a nuisance, adware carries genuine security risk:

- **Credential and PII exposure.** Many adware SDKs exfiltrate browsing history, form data, and device identifiers to marketing servers, violating **[[GDPR]]** and **HIPAA**.
- **TLS trust subversion.** The **Superfish** (CVE-2015-2077) and **eDellRoot** (CVE-2015-7755) incidents installed trusted root CAs whose private keys were extractable, enabling any attacker on the network to impersonate any HTTPS site.
- **Pivot to heavier malware.** Adware installers frequently serve as **[[Loader|loaders]]** or **[[Dropper|droppers]]** that later fetch info-stealers, cryptominers, or ransomware. The SocGholish fake-update campaign has delivered **WastedLocker** ransomware.
- **Resource consumption.** Background ad rendering and click fraud degrade CPU, battery, and bandwidth.
- **Mobile risk.** Android adware families like **Judy**, **HummingBad**, and **Joker** have reached tens of millions of installs via Google Play, subscribing users to premium SMS services.

Detection signals: unusual DNS queries to ad-injection domains, unexpected browser extensions, new scheduled tasks/services under `%APPDATA%`, rogue proxy or PAC settings, and unknown root certificates in the trust store.

## Defensive Measures

- **Enable PUP/PUA detection** in your AV/EDR (Microsoft Defender: `Set-MpPreference -PUAProtection Enabled`; Malwarebytes: enabled by default).
- **Deploy browser management policies** via **Group Policy** or Chrome/Edge enterprise ADMX: restrict extension installation to an allowlist, block developer-mode extensions, lock the default search engine.
- **Application allowlisting** with **[[AppLocker]]**, **[[Windows Defender Application Control (WDAC)]]**, or **[[Software Restriction Policies]]**.
- **Standard user accounts** — deny local admin rights to prevent most bundleware from installing services or drivers.
- **DNS filtering** using **[[Pi-hole]]**, NextDNS, Cisco Umbrella, or Quad9 to block known ad-injection and malvertising domains.
- **Browser hardening**: uBlock Origin, HTTPS-only mode, disable Web Push notifications by default.
- **Endpoint baseline monitoring** of the Windows certificate store (`certutil -store Root`) to detect rogue CAs.
- **User awareness training** about installer UIs, bundled offers, and fake update prompts.

## Lab / Hands-On

Safe experimentation is essential — only detonate samples inside an isolated VM with no production network access.

**Setup:**
```
# Windows 10 analysis VM in VirtualBox/Proxmox
# Snapshot before each run. Disable shared folders and clipboard.
# Network: host-only or INETSIM for fake internet
```

**Tools to install:**
- **Process Monitor** and **Process Explorer** (Sysinternals) — observe file, registry, and process activity.
- **Autoruns** — enumerate persistence points after infection.
- **Wireshark** — capture ad-injection C2 traffic.
- **Fiddler** or **mitmproxy** — inspect HTTPS beacons (install the tool's CA in the VM).
- **RegShot** — diff the registry before/after installation.
- **CertUtil** — `certutil -store Root` to list root CAs; look for unexpected issuers.

**Exercises:**
1. Obtain a known-PUP installer from a research repo (e.g., theZoo, MalwareBazaar tag `adware`). Run it inside the VM; watch Procmon for writes to `HKCU\...\Run` and `%APPDATA%`.
2. Compare Autoruns output pre- and post-infection; identify the persistence mechanism.
3. Use Wireshark to capture DNS; correlate queried domains with threat-intel lookups (VirusTotal, URLhaus).
4. Pract