---
domain: "threats"
tags: [attack, dns, social-engineering, web-security, domain-security, identity]
---
# Domain hijacking

**Domain hijacking** (also called **domain theft**) is the unauthorized seizure of operational or registration control over a domain name without the consent of its lawful registrant. Attackers exploit it to redirect traffic, intercept email, impersonate brands, host [[phishing]] payloads, or extort the rightful owner — most commonly by compromising registrar accounts, socially engineering registrar support staff, or abusing the **EPP inter-registrar transfer workflow**. It is distinct from [[DNS hijacking]], which alters name resolution without changing ownership records, though the two techniques are frequently chained together in sophisticated campaigns.

---

## Overview

Domain hijacking sits at the intersection of identity, infrastructure, and brand security. A domain name is simultaneously a technical identifier resolved by the [[DNS]] and a legal asset governed by **ICANN** contracts, registry operators (such as Verisign for `.com` or PIR for `.org`), and accredited registrars (such as GoDaddy, Namecheap, MarkMonitor, or Cloudflare Registrar). Hijacking may occur at any layer of this chain: the registrant's contact email, the registrar account, the registry record, or the DNS delegation itself. Because a single successful hijack can affect web traffic, email delivery, SaaS logins tied to the domain via [[SSO]] or password-reset flows, and any TLS certificate issued under **ACME domain-validation**, the blast radius is disproportionate to the effort required.

The earliest high-profile hijack was **sex.com** in 1995, when Stephen Michael Cohen used a forged letter submitted to Network Solutions to transfer the domain away from Gary Kremen. The ensuing litigation (*Kremen v. Cohen*, 9th Cir. 2003) established in U.S. case law that domain names are a form of intangible property subject to conversion claims. Subsequent decades produced a steady cadence of incidents: the 2015 **Lenovo.com** hijack by Lizard Squad (achieved via social engineering of the Web.com registrar workflow), the 2020–2021 **perl.com** hijack (originating with a compromised registrant email that had been dormant for years), and the 2021 **Google.com.ar** incident in which an individual legally purchased the lapsed record during a renewal gap for roughly US$2.90, briefly resolving Google's regional traffic to his hosting.

Nation-state actors have systematized the technique. The **Sea Turtle** campaign (2017–2019), publicly documented by Cisco Talos, manipulated registrar and registry records for dozens of government and infrastructure domains across the Middle East and North Africa, staging man-in-the-middle credential harvesting by obtaining valid TLS certificates for victim domains before redirecting traffic. This activity prompted an unprecedented **ICANN Emergency Security Advisory in February 2019** urging the full deployment of [[DNSSEC]] and [[MFA]] across the global registration ecosystem.

Economically, hijacked domains are monetized through traffic-parking ad revenue, resale via drop-catching marketplaces, and ransomware-style extortion. Because ICANN's **Transfer Dispute Resolution Policy (TDRP)** and **Uniform Rapid Suspension (URS)** rely on administrative review rather than real-time controls, recovery can take days to weeks — during which the hijacker continues to exploit the domain's email, web, and SEO equity.

---

## How It Works

A domain's authoritative record lives at the **registry** (one per TLD) and is mutated through a **registrar** using the **Extensible Provisioning Protocol (EPP)**, defined in RFCs 5730–5734, transported over TLS on **TCP port 700**. The registrant interacts with the registrar via a web console or API; the registrar speaks EPP to the registry. Hijacking disrupts this chain at its weakest link — almost always the human-facing registrar account.

### Stage 1 — Reconnaissance

The attacker begins with passive enumeration to identify the registrar, registrant contact email, expiry date, and transfer-lock status.

```bash
# Query WHOIS for registration metadata
whois example.com | grep -Ei 'registrar:|status:|email:|expiry|expires'

# Query RDAP (modern, structured replacement for WHOIS)
curl -s https://rdap.verisign.com/com/v1/domain/EXAMPLE.COM | jq '{registrar:.entities,status:.status,ns:.nameservers}'

# Confirm current NS delegation
dig +short NS example.com
```

The critical field is **Domain Status**. The EPP status codes break down as follows:

| EPP Status Code | Meaning |
|---|---|
| `clientTransferProhibited` | Transfer locked at registrar level (can be unlocked by account holder) |
| `serverTransferProhibited` | Registry-level lock — requires out-of-band verification to lift |
| `pendingTransfer` | Transfer is in progress (5-day window active) |
| `clientHold` | Domain suspended at registrar level; DNS not delegated |

### Stage 2 — Credential or Channel Compromise

The attacker targets the registrant's contact email account (enabling password resets at the registrar), phishes the registrar console directly, exploits a weak or bribeable registrar support workflow, or pivots through a compromised insider. Many classic hijacks originate with a forgotten registrant email address that has been abandoned and re-registered by a third party.

### Stage 3 — AuthInfo Code Exfiltration

Once authenticated inside the registrar account, the attacker:

1. Disables the transfer lock (`clientTransferProhibited` → removed)
2. Requests the **AuthInfo code** (also called the **EPP transfer code** or **authorization code**)

The AuthInfo code is a shared secret between the registrant and registry that authorizes a gaining registrar to pull the domain in. In raw EPP it appears as:

```xml
<!-- EPP <info> response fragment -->
<authInfo>
  <pw>9x!ZQ-transferCode-7tRm</pw>
</authInfo>
```

This code should be treated with the same sensitivity as a root credential.

### Stage 4 — Gaining-Registrar Transfer

The attacker opens an account at a second registrar, submits a transfer request with the stolen AuthInfo code, and — since the contact email is also compromised — approves the ICANN transfer confirmation message. Under current ICANN Transfer Policy, a registrar may also complete the transfer by **implicit approval after 5 calendar days** of silence from the registrant. During this 5-day window, the domain is functionally in transit and can no longer be easily recovered by the losing registrar.

### Stage 5 — Post-Transfer Exploitation

With ownership transferred, the attacker:

- Rewrites NS records to an adversary-controlled authoritative server
- Issues new [[TLS]] certificates via ACME HTTP-01 or DNS-01 challenge validation (trivially passing because they now control the zone)
- Creates MX records to intercept all inbound email — including password-reset messages from every SaaS platform associated with the domain
- May resell, ransom, or maintain long-term persistent access

### Variants

| Variant | Mechanism | Ownership Changed? |
|---|---|---|
| **Full transfer hijack** | EPP transfer via stolen AuthInfo | Yes |
| **Registrar-account hijack** | NS record change inside existing registrar | No (WHOIS still shows victim) |
| **Registry-level hijack** | EPP modification at registry tier, bypassing registrar | Partial |
| **Expired-domain drop-catch** | Legal re-registration during `pendingDelete` window | Yes |

---

## Key Concepts

- **Registrar vs. Registry.** The **registrar** is the retailer that sells and manages domain names for end-users (GoDaddy, Namecheap, MarkMonitor); the **registry** is the wholesale operator of the TLD zone database (Verisign for `.com`, PIR for `.org`). Hijacking can occur at either layer, each requiring different defenses.
- **AuthInfo / EPP Transfer Code.** A per-domain secret password used to authorize inter-registrar transfers. Disclosure of this code to any party other than a designated gaining registrar initiates an irrevocable 5-day transfer clock. It must be rotated after any suspected exposure and stored like a privileged credential.
- **Client Lock vs. Server (Registry) Lock.** `clientTransferProhibited` is enforced by the registrar and toggled by the account holder — it is the baseline defense. `serverTransferProhibited` (**Registry Lock**) is enforced by the registry itself and requires a separate, out-of-band verification process (typically a phone call to the registry) to lift, providing a substantially higher security barrier for high-value domains.
- **ICANN Transfer Policy.** Governs inter-registrar domain transfers, including the **60-day post-registration and post-transfer lock** period, the **5-day implicit-approval window**, and the **Transfer Dispute Resolution Policy (TDRP)** available to registrants who have suffered an unauthorized transfer.
- **Drop-Catching.** The automated, high-speed re-registration of a domain the instant it exits the `redemptionPeriod → pendingDelete → available` deletion lifecycle. Used by legitimate resellers and opportunistic hijackers alike; the Google.com.ar (2021) and Google Vietnam (2015) incidents are prominent examples of this failure mode.
- **Certificate Transparency (CT) Monitoring.** Every certificate issued by a trusted CA must be logged to a **Certificate Transparency log** (RFC 6962). Monitoring CT feeds (e.g., via crt.sh or certstream) for unexpected certificate issuance against your domains is one of the fastest ways to detect a post-hijack exploitation attempt.
- **CAA Record.** A **Certification Authority Authorization** DNS record (RFC 8659) that restricts which certificate authorities are permitted to issue certificates for a domain. Publishing a CAA record does not prevent a hijacker from changing nameservers, but it imposes a documented constraint on rogue certificate issuance that compliant CAs are contractually obligated to honor.

---

## Exam Relevance

**SY0-701 Exam Mapping:** Domain 2.2 (Threat Vectors and Attack Surfaces), Domain 2.4 (Indicators of Malicious Activity), Domain 4.6 (Security Awareness Practices)

**Key distinctions to memorize — these are high-frequency question discriminators:**

| Term | What changes | What stays the same |
|---|---|---|
| **Domain hijacking** | Registration ownership / NS records | (nothing — full control seized) |
| **[[DNS hijacking]]** | Resolver cache or response | Domain registration / WHOIS |
| **[[Typosquatting]]** | A *different* lookalike domain is registered | Legitimate domain is untouched |
| **[[Pharming]]** | Client-side resolution (hosts file, router) | Domain registration |
| **[[Cybersquatting]]** | Bad-faith trademark registration | A legal issue, not a technical exploit |

**Common question patterns:**

- A scenario describes an attacker who "changed the registrar for a domain without the owner's knowledge" — the answer is **domain hijacking**, not DNS poisoning.
- A scenario describes traffic being redirected without any registration change — the answer is **DNS hijacking** or **pharming**.
- The preventive control most commonly paired with domain hijacking in answer choices: **Registrar lock / transfer lock**.
- CompTIA also associates domain hijacking with **social engineering** because many real-world attacks exploit registrar support workflows rather than technical vulnerabilities.

**Gotcha:** The exam may describe a scenario where the attacker intercepts email and issues fake certificates. This describes the *consequence* of a hijack, not a separate attack — don't be led to answers like "man-in-the-middle" or "certificate spoofing" as the root cause.

---

## Security Implications

Domain hijacking confers three high-value capabilities simultaneously: **traffic interception**, **email interception**, and the ability to **pass any domain-validation (DV) certificate challenge** — which in turn satisfies DV-based [[SSO]], ACME, and password-reset workflows across virtually every SaaS ecosystem tied to the domain. This is why hijacking is classified as a **tier-0 identity threat** in enterprise security models.

**Notable incidents:**

- **Sea Turtle (2017–2019, Cisco Talos):** State-aligned actors — likely Iranian in origin — altered registrar and registry records for at least 40 organizations across 13 countries in MENA. Attackers obtained valid TLS certificates for victim domains after taking control of DNS, then staged MitM credential harvesting against government ministries, military organizations, and ISPs.
- **perl.com (January 2021):** The domain was transferred away from its registrant following compromise of an associated registrant email identity. The hijacked domain temporarily pointed to an IP address historically associated with malware distribution. The Perl community regained control within days, but the incident highlighted how aging registrant contact emails become single points of failure.
- **DNSpionage / ICANN Emergency Advisory (February 2019):** ICANN issued an unprecedented emergency notice after sustained hijack campaigns against government-operated domains, urging universal DNSSEC adoption and MFA implementation at registrars.
- **Lenovo.com (February 2015):** Lizard Squad socially engineered Web.com's registrar support workflow to redirect Lenovo's website and intercept corporate email, with the company's main domain pointing to a Lizard Squad page for several hours.
- **Google.com.ar (April 2021):** A security researcher exploited a lapsed registration to legally purchase the ccTLD record for approximately US$2.90, demonstrating that expiry-driven hijacking requires no technical compromise whatsoever.

**Detection signals to monitor:**

- Unexpected WHOIS/RDAP diffs in registrar name, nameservers, or contact email
- Disappearance of `clientTransferProhibited` from EPP status without a work order
- New certificate issuance appearing in CT logs from an unfamiliar CA
- NS records pointing to unrecognized authoritative nameserver infrastructure
- SPF/DKIM/DMARC failures for mail claiming to originate from the domain
- DNSSEC validation failures (if deployed) indicating unsigned or mis-signed delegation

---

## Defensive Measures

**Registrar-Level Controls:**

- **Enable all available client-side EPP locks** — `clientTransferProhibited`, `clientUpdateProhibited`, and `clientDeleteProhibited` — on every production and brand-critical domain. These are free, immediate, and defeat the majority of commodity transfer attempts.
- **Purchase Registry Lock** (`serverTransferProhibited`) for high-value domains. Offered by Verisign, MarkMonitor, CSC, and select registry operators; modifications require separate, out-of-band human verification (typically a phone call). Cost: approximately US$100–$500/year — trivial relative to brand value.
- **Enforce [[MFA]] on registrar accounts**, preferably FIDO2/WebAuthn hardware security keys. Avoid SMS OTP due to [[SIM swapping]] exposure. Treat the registrar console as a tier-0 privileged interface.

**Registrant Email Security:**

- Use a **dedicated, security-hardened email address** for registrant contact — not a personal or shared account.
- Apply its own strong MFA, and use a different provider or registrar for this email to avoid single-point compromise.
- Audit and update registrant contact addresses in WHOIS annually.

**DNS and Certificate Controls:**

- **Deploy [[DNSSEC]]** on all zones. While DNSSEC does not prevent registration-layer hijacking, it makes unauthorized NS substitution cryptographically visible as validation failures and prevents silent interception of DNS responses.
- **Publish [[CAA]] records** to restrict certificate issuance to authorized CAs:

```dns
example.com. CAA 0 issue "letsencrypt.org"
example.com. CAA 0 iodef "mailto:security@example.com"
```

**Monitoring:**

- Monitor **Certificate Transparency logs** for unexpected issuance: [crt.sh](https://crt.sh), certstream, or commercial solutions such as DomainTools Iris or Microsoft Defender EASM.
- Implement automated **WHOIS/RDAP drift detection** (see Lab section).
- Register for **ICANN's WHOIS Data Problem Reporting System (WDPRS)** alerts.

**Operational Controls:**

- Register domains for **5–10 year terms** to minimize accidental expiry.
- Maintain a formal **domain inventory** documenting registrar