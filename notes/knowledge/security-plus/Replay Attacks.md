# Replay Attacks

## What it is

In FIFA, imagine you record your opponent's perfect free-kick — the exact stick movement, power bar, and timing — and then play it back move-for-move on your own controller to score the same goal. You didn't invent anything; you captured a working sequence and re-ran it. That's exactly what a **replay attack** does — an attacker captures legitimate network traffic and retransmits it later to impersonate the original sender or trigger the same effect.

**Technical definition:** A replay attack is a network attack in which an adversary intercepts valid data transmissions (typically authentication tokens, session identifiers, or signed messages) and fraudulently retransmits them to gain unauthorized access or repeat an action.

## Why it matters

Replay attacks defeat authentication systems that rely on static credentials or predictable message formats — the attacker never needs to crack the password, only resend the captured handshake. This breaks confidentiality and integrity of session establishment, enables unauthorized fund transfers, account takeover, and bypass of MFA tokens that lack freshness checks. SY0-701 Objective 2.4 lists "replay" explicitly under network attacks; CompTIA's favorite trap is conflating replay with **on-path (MITM)** — replay does not require live interception during the victim's session, only capture-then-resend, and the canonical defense is a **nonce** or timestamp, not encryption alone (encrypted traffic is still replayable if the ciphertext itself authenticates).

## Key facts

### Attack mechanics

- **Capture phase:** Attacker uses [[packet sniffing]] tools ([[Wireshark]], [[tcpdump]], [[Bettercap]]) on an unprotected segment, [[rogue access point]], or via [[ARP poisoning]] to obtain traffic.
- **Replay phase:** Captured frames are retransmitted using tools like [[Scapy]], [[tcpreplay]], or custom scripts.
- **Targets:** [[Session cookies]], [[Kerberos]] tickets, [[NTLM]] hashes (see [[Pass-the-Hash]]), [[RFID]] badge reads, vehicle key fobs, [[Wi-Fi handshakes]] (WPA2 four-way handshake), API tokens, [[OAuth]] bearer tokens.

### Replay vs. related attacks

| Attack | Live interception required? | Modifies data? | Goal |
|---|---|---|---|
| **Replay** | No — capture then resend later | No | Re-authenticate or repeat action |
| **On-path / [[MITM]]** | Yes | Optional | Eavesdrop or alter in transit |
| **[[Session hijacking]]** | Often yes | No (uses live session) | Take over active session |
| **[[Pass-the-Hash]]** | No | No | Reuse credential material |

### Defenses (memorize these)

- **[[Nonce]]** — number used once; server rejects duplicate values. Primary defense.
- **[[Timestamp]] + clock skew window** — messages outside acceptable window are dropped.
- **Sequence numbers** — used in [[IPsec]] [[ESP]] and [[TLS]] record layer; out-of-order or repeated numbers rejected.
- **[[Challenge-response authentication]]** — server issues unique challenge each session ([[CHAP]], [[Kerberos]] timestamp in authenticator).
- **Mutual authentication + [[TLS]] 1.3** — ephemeral keys per session via [[ECDHE]] make captured handshakes useless.
- **[[HMAC]] with session-specific keys** — captured MAC won't validate in a new session.
- **Short-lived tokens** — [[JWT]] with low `exp`, OAuth refresh rotation.

### Real-world examples

- **WPA2 KRACK (2017):** Forced nonce reuse in the four-way handshake — replay-adjacent vulnerability.
- **Automotive keyless entry:** [[RollJam]] device captures and replays rolling codes against vehicles.
- **Kerberos golden/silver ticket reuse** when timestamps aren't enforced.
- **API replay** when requests lack `nonce` or `X-Request-ID` validation.

### Exam triggers

- Question mentions "captured authentication traffic" + "resent later" → **replay**.
- Question asks for the *defense* → **nonce** or **timestamp**, not "encryption."
- Question describes attacker sitting between client and server in real time → **on-path**, not replay.

## Related concepts

[[Nonce]] · [[On-path attack]] · [[Session hijacking]] · [[Pass-the-Hash]] · [[Kerberos]] · [[TLS 1.3]] · [[IPsec]] · [[Challenge-response authentication]] · [[Wireless attacks]] · [[Cryptographic freshness]]

---
*Source: VIRGIL knowledge base — 2026-05-08*