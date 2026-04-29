# nf_nat_sip

## What it is
Like a postal worker who must rewrite both the envelope address AND the letter inside when forwarding your mail, `nf_nat_sip` is a Linux kernel module that rewrites IP addresses and ports embedded *inside* SIP message bodies during Network Address Translation — not just the outer IP headers. It is a NAT helper (connection tracking helper) that understands the SIP protocol at Layer 7, ensuring that VoIP signaling messages contain correct contact addresses after NAT traversal.

## Why it matters
Without `nf_nat_sip`, a SIP INVITE packet's `Contact:` and `Via:` headers would still contain the private RFC 1918 address after NAT, causing the remote VoIP server to try routing calls back to a non-routable address — breaking the call. Attackers who gain control of a SIP ALG (Application Layer Gateway) using this module can intercept or redirect VoIP sessions, since the module has deep visibility into unencrypted SIP traffic before it's translated.

## Key facts
- `nf_nat_sip` depends on `nf_conntrack_sip` — the connection tracking helper that parses SIP; NAT rewriting only occurs after conntrack understands the session
- It rewrites SIP headers including `Contact:`, `Via:`, `Record-Route:`, and SDP body fields (`c=` and `m=` lines for RTP media)
- The module opens *pinholes* (dynamic firewall rules) for associated RTP media streams, which can expand the attack surface if SIP traffic is malicious or crafted
- Encrypted SIP (SIPS/TLS) bypasses `nf_nat_sip` entirely — the module cannot parse or rewrite encrypted payloads
- SIP ALG interference caused by this module is a common misconfiguration complaint; security practitioners sometimes explicitly disable it (`rmmod nf_nat_sip`) when using dedicated SBC (Session Border Controllers)

## Related concepts
[[Network Address Translation]] [[SIP Protocol Security]] [[nf_conntrack]] [[Application Layer Gateway]] [[VoIP Security]]