---
domain: "social-engineering"
tags: [caller-id-spoofing, vishing, telecom, sip, stir-shaken, social-engineering]
---
# Caller ID Spoofing

**Caller ID spoofing** is the deliberate falsification of the **Calling Party Number (CPN)** or **Calling Name (CNAM)** transmitted to a recipient's telephone so that the displayed identity is not the true origin of the call. The attack exploits the historically trust-based design of the [[Public Switched Telephone Network]] and modern [[VoIP]]/[[SIP]] signaling, where the originating party populates the calling-number field without cryptographic verification. It is the foundational enabler of [[Vishing]], robocall fraud, and executive impersonation, and is the central problem that the [[STIR/SHAKEN]] framework and the [[TRACED Act]] were designed to address.

---

## Overview

The legacy Public Switched Telephone Network (PSTN) was engineered in an era when every originating switch was owned by a licensed, regulated carrier. Signaling System No. 7 ([[SS7]]) and its ISUP layer carry the Calling Party Number in an **Initial Address Message (IAM)** as an informational field; the terminating switch accepts whatever value the upstream switch asserts. This permissive model was tolerable when only Bell System subsidiaries and a handful of Regional Bell Operating Companies could originate traffic. With deregulation of long distance, the rise of PRI/T1 trunks for enterprise PBXs, and finally the liberalization of VoIP interconnection, the ability to originate calls—and to set an arbitrary calling number—became commercially accessible to anyone with a credit card and a SIP trunk account.

There are entirely legitimate reasons to modify caller ID. A call center routing outbound calls through hundreds of trunks should display a single, callable return number. A physician returning a patient call from a personal cell phone may legitimately present the clinic's number. A domestic-violence shelter may suppress its actual DID to protect residents. U.S. law—specifically the **Truth in Caller ID Act of 2009**—permits caller ID modification *unless* the intent is to "defraud, cause harm, or wrongfully obtain anything of value." The United Kingdom, Canada (CRTC), and the EU have analogous statutes, but enforcement has historically been weak because tracing a spoofed call across multiple interconnected carriers is technically demanding and cross-jurisdictional.

Voice-over-IP massively industrialized the problem. In SIP, the calling identity appears in several headers—`From`, `P-Asserted-Identity` (RFC 3325), `Remote-Party-ID`, and `Contact`—all of which are plain text that any SIP User Agent or PBX can freely set. Open-source PBX platforms such as [[Asterisk]] and [[FreePBX]] expose a `CALLERID()` dialplan function. Commercial telephony APIs such as Twilio, Bandwidth, Plivo, and Telnyx allow programmatic call origination with a selectable "from" number, subject to varying ownership-verification policies. Offshore or unscrupulous **wholesale SIP trunk providers** accept any calling number with no validation, which is how the bulk of fraudulent robocalls enter the North American network.

The Federal Trade Commission logged over 1.8 billion complaint-reported robocalls during peak years (2018–2021), and the FCC estimated total robocall volume exceeded 50 billion annually at its height. Headline frauds enabled by caller ID spoofing include the **IRS impersonation scam** (which defrauded victims of over $100 million between 2013 and 2018), **Social Security Administration impersonation**, **tech-support scams** masquerading as Microsoft or Apple, **Wangiri** ("one-ring") premium-rate callback scams, and targeted **CEO/CFO voice fraud** against enterprises. Caller ID spoofing is also the mechanism behind [[SWATting]], in which an attacker spoofs a victim's number to report a fabricated emergency to law enforcement.

The regulatory and technical response consolidated around **STIR/SHAKEN** (Secure Telephone Identity Revisited / Signature-based Handling of Asserted information using toKENs), a suite of IETF and ATIS standards that cryptographically sign the calling number inside a SIP `Identity` header using a JWT. The FCC, under authority of the TRACED Act (2019), mandated STIR/SHAKEN deployment on IP portions of U.S. carrier networks by June 30, 2021. Critically, the framework does not *prevent* spoofing at the packet level; it provides **attestation** so that downstream carriers and analytics engines can distinguish verified from unverified caller identities and label or block accordingly.

---

## How It Works

Caller ID spoofing works because the calling number is a **signaling field, not a cryptographic credential**. The mechanism varies by transport layer.

### Legacy SS7 / ISUP (TDM Trunks)

When a call originates on a PRI or an SS7 trunk, the originating switch sends an ISUP IAM message containing a *Calling Party Number* parameter. The PRI Q.931 `SETUP` message carries equivalent information in the *Calling Party Number Information Element*. The terminating switch forwards this value to the CPE unchanged. Most carriers historically honored whatever their interconnect partner sent, provided the partner was a trusted peer. Enterprise PBX administrators with ISDN PRI trunks could override the outbound CPN on a per-extension or per-call basis with no carrier-side verification.

### VoIP / SIP

In SIP, the `From` header is set by the User Agent Client and is the primary source of caller ID unless the trunk provider overrides it. RFC 3325 defines `P-Asserted-Identity` (PAI), intended to be asserted only by a trusted network element and typically the field tier-1 carriers key on for both billing and displayed caller ID. An attacker-crafted `INVITE` looks like this:

```
INVITE sip:+15555550100@carrier.example.net SIP/2.0
Via: SIP/2.0/UDP 203.0.113.42:5060;branch=z9hG4bK-attack-001
From: "Internal Revenue Service" <sip:+12025140000@attacker.tld>;tag=abc123
To: <sip:+15555550100@carrier.example.net>
P-Asserted-Identity: <sip:+12025140000@carrier.example.net>
Call-ID: 4fd6c1e8-spoof@attacker.tld
CSeq: 1 INVITE
Contact: <sip:attacker@203.0.113.42:5060>
Max-Forwards: 70
Content-Type: application/sdp
Content-Length: ...
```

The victim's carrier renders **"Internal Revenue Service / 202-514-0000"**—the real published number of the U.S. Department of Justice—on the handset, even though the packet originated from `203.0.113.42`. The `From` display name and number are entirely attacker-controlled.

### Asterisk Dialplan Example

On any Asterisk PBX with an outbound SIP trunk to a permissive ITSP, a single dialplan block sets the outbound caller ID before dialing:

```
[internal]
exten => _1NXXNXXXXXX,1,NoOp(Outbound with spoofed CID)
 same => n,Set(CALLERID(name)=Bank of Trust)
 same => n,Set(CALLERID(num)=12125551212)
 same => n,Dial(PJSIP/${EXTEN}@wholesale-trunk)
 same => n,Hangup()
```

### REST API–Based Origination

Modern CPaaS providers expose call origination via REST. A compliant provider requires number ownership or a verified-caller-ID flow, but attackers using stolen accounts or compliant offshore providers use the same API primitive:

```
POST /2010-04-01/Accounts/{AccountSid}/Calls.json
Authorization: Basic {Base64-encoded SID:Token}

From=%2B12025140000&To=%2B15555550100&Url=https%3A%2F%2Ftwiml.example%2Fvoice
```

### Neighbor Spoofing

A refinement in which the attacker generates a `From` number sharing the **NPA-NXX** (area code + exchange) of the target. Targets are statistically more likely to answer a call that appears local. Automated dialers randomize the last four digits per call across an entire outbound campaign.

### STIR/SHAKEN Attestation Flow

When STIR/SHAKEN is in effect, the originating carrier (Originating Service Provider, OSP) signs a **PASSporT** (Personal Assertion Token, RFC 8225)—a compact JWT—and attaches it to the SIP `Identity` header:

```
Identity: eyJhbGciOiJFUzI1NiIsInR5cCI6InBhc3Nwb3J0IiwieDV1IjoiaHR0cHM6Ly9jZXJ0LmV4YW1wbGUvY2VydC5wZW0ifQ
.eyJhdHRlc3QiOiJBIiwiZGVzdCI6eyJ0biI6WyIxNTU1NTU1MDEwMCJdfSwiaWF0IjoxNjk4MDAwMDAwLCJvcmlnIjp7InRuIjoiMTIwMjUxNDAwMDAifSwib3JpZ2lkIjoiMWEyYjNjIn0
.{signature};info=<https://cert.example/cert.pem>;alg=ES256;ppt=shaken
```

The three attestation levels are:
- **A (Full Attestation)** — The OSP authenticated the subscriber and verified their right to use the calling number.
- **B (Partial Attestation)** — The OSP authenticated the subscriber but cannot verify the number.
- **C (Gateway Attestation)** — The call entered from an untrusted gateway; the OSP cannot vouch for the number at all.

The terminating carrier (VSP) verifies the JWT signature against the certificate chain rooted at the **STI-PA** (Policy Administrator; iconectiv in the U.S.). A passing check stamps the call with `verstat=TN-Validation-Passed` in the SIP `To` header PAI parameter. Analytics platforms and handset displays use this value to label calls "Verified ✓" or flag them as potential spam. A spoofed `From` with a valid signature for a *different* number will fail verification, exposing the spoof.

---

## Key Concepts

- **Calling Party Number (CPN)** — The E.164 telephone number asserted by the originating switch in ISUP/SS7 or SIP `From`/`PAI` headers. This is the value most handsets display when no CNAM lookup is performed.
- **CNAM (Calling Name)** — A 15-character display name retrieved via an SS7 TCAP query from the terminating carrier's CNAM database, keyed on the CPN. Because CNAM is a *lookup* on the received CPN, a spoofed CPN automatically produces a spoofed CNAM display name.
- **ANI (Automatic Number Identification)** — A billing-side identifier generated by the originating carrier, used by 911 PSAPs and toll-free services. ANI traverses separate signaling and is significantly harder to spoof than CID, though not impossible via certain interconnect manipulations.
- **P-Asserted-Identity (PAI)** — SIP header (RFC 3325) intended to carry the network-verified caller identity between trusted SIP nodes within a single administrative domain. Abuse by attackers who control a compliant SIP proxy is the key attack vector in VoIP-originated spoofing.
- **PASSporT (Personal Assertion Token)** — The RFC 8225 JWT structure at the core of STIR, containing claims for `orig` (originating number), `dest` (destination number), `attest` (attestation level), `iat` (issued-at timestamp), and `origid` (unique call origination identifier). The `iat` claim enforces a short validity window to prevent replay.
- **STIR/SHAKEN** — The combined IETF (RFC 8224/8225/8226) and ATIS/SIP-Forum deployment standard that signs calling number assertions at the carrier level; the primary technical control mandated by the FCC under the TRACED Act.
- **Attestation Level (A/B/C)** — Originating carrier's categorical claim about how strongly the caller's right to use the number was verified. Level A is the strongest; Level C indicates the carrier could not verify the number at all.
- **Neighbor Spoofing** — Generating a calling number that shares the NPA-NXX prefix of the target to exploit local-caller familiarity and increase answer rates.
- **TRACED Act (2019)** — U.S. Telephone Robocall Abuse Criminal Enforcement and Deterrence Act; authorizes the FCC to mandate STIR/SHAKEN, levy fines up to $10,000 per spoofed call, and extends the statute of limitations for enforcement actions.
- **Robocall Mitigation Database (RMD)** — The FCC registry in which every U.S. voice service provider must file a STIR/SHAKEN implementation status or a robocall mitigation plan; providers not listed may have their traffic blocked by downstream carriers under FCC rules effective September 2021.

---

## Exam Relevance

On the **CompTIA Security+ SY0-701** exam, Caller ID spoofing is tested within **Domain 2.2 (Threat Vectors and Attack Surfaces)** and implicitly in **Domain 5 (Security Program Management and Oversight)** via security awareness.

**High-yield exam tips:**

- **Vishing vs. spoofing:** Recognize that *vishing* (voice phishing) is the attack; caller ID spoofing is the *enabling mechanism*. Exam scenarios describe a caller impersonating a bank, the IRS, or IT support—the answer is "vishing," with spoofing as context. Don't conflate the two.
- **Distinguish voice-channel attacks:** Know that **vishing** = voice call, **smishing** = SMS/text, **phishing** = email, **whaling** = targeted executive phishing. SY0-701 tests all four and expects you to distinguish them by channel.
- **Social engineering principles involved:** Spoofed authority caller ID pairs with **impersonation**, **pretexting**, and exploitation of **authority** and **urgency**—all named SE principles in the exam objectives.
- **STIR/SHAKEN as the mitigation:** When asked "which technology mitigates caller ID spoofing at the carrier level," the answer is **STIR/SHAKEN**. Distractors include TLS (encrypts transport, doesn't verify identity), IPsec (network-layer encryption), and DNSSEC (DNS integrity—unrelated).
- **Procedural control:** "Call back the requesting party using a number obtained from an official source" is the canonical procedural defense. The exam rewards choosing out-of-band verification over technical controls when the scenario involves a human decision point.
- **Gotcha — voicemail variant:** A question may describe an attacker leaving a voicemail with a spoofed call-back number. This is still vishing/social engineering, not a different attack category.
- **Gotcha — firewall blocking:** Blocking calls at a firewall is not a standard answer for this attack; STIR/SHAKEN attestation and call-analytics filtering are correct at the network layer.

---

## Security Implications

Caller ID spoofing amplifies the effectiveness of virtually every telephone-based threat vector:

**Financial Fraud.** The long-running **IRS impersonation scam** (2013–2018) spoofed Washington, D.C. "202" area-code numbers and extracted over $100 million from victims. Operation Junglee (2016), a coordinated action by Mumbai Police and the U.S. DOJ, dismantled a Thane, India call-center network responsible for a substantial portion of this fraud. The **SSA impersonation scam** has been the top consumer fraud report category to the FTC since 2019.

**Corporate Voice-BEC.** Attackers spoof the CEO's actual mobile number to call the CF