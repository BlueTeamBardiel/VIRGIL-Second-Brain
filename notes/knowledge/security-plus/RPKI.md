# RPKI

## What it is
Think of it like a notary system for internet routing: before a post office accepts a package rerouting request, the notary must verify the requester actually owns that destination address. Resource Public Key Infrastructure (RPKI) is a cryptographic framework that allows IP address holders to digitally sign Route Origin Authorizations (ROAs), proving which Autonomous Systems (AS) are legitimately allowed to announce specific IP prefixes via BGP.

## Why it matters
In 2018, attackers hijacked roughly 1,300 IP addresses belonging to Amazon Route 53 by announcing a more-specific BGP prefix, redirecting cryptocurrency wallet traffic through a malicious server and stealing funds. RPKI prevents this by allowing routers to drop BGP announcements that lack a valid, cryptographically-signed ROA — if Amazon had signed their prefixes, downstream routers could have rejected the fraudulent announcement automatically.

## Key facts
- A **Route Origin Authorization (ROA)** is the core RPKI object: it binds an IP prefix to an authorized origin AS number and is signed by the address holder's certificate
- RPKI certificates are issued by **Regional Internet Registries (RIRs)** — ARIN, RIPE NCC, APNIC, LACNIC, and AFRINIC — forming a trust anchor hierarchy
- Routers can enforce RPKI in three states: **Not Found** (no ROA exists, route accepted by default), **Valid** (ROA matches, route accepted), and **Invalid** (ROA contradicts announcement, route should be dropped)
- RPKI does **not** protect against path manipulation attacks (e.g., BGP route hijacking mid-path) — it only validates the *origin* AS, not the full AS path
- As of recent measurements, roughly **50% of global prefixes** have RPKI ROAs, but enforcement (route origin validation) remains inconsistently deployed by ISPs

## Related concepts
[[BGP Hijacking]] [[Border Gateway Protocol]] [[Public Key Infrastructure]] [[Route Origin Validation]] [[Autonomous System]]