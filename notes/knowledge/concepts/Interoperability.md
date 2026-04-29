# Interoperability

## What it is
Like a universal power adapter that lets your American laptop plug into a European outlet — interoperability is the ability of different systems, tools, or protocols to exchange and use information seamlessly. In cybersecurity, it refers to the capacity of diverse security products, platforms, and standards to communicate and function together without custom integration work.

## Why it matters
In a SOC environment, a SIEM must ingest logs from firewalls, endpoint agents, cloud platforms, and IDS tools from different vendors — if these don't interoperate via common formats like CEF or STIX/TAXII, analysts face blind spots where threats hide in siloed data. The 2020 SolarWinds attack succeeded partly because the backdoor's behavior blended into normal network traffic that fragmented, non-interoperable monitoring tools failed to correlate across domains.

## Key facts
- **STIX/TAXII** is the dominant standard for interoperable threat intelligence sharing — STIX defines the *format*, TAXII defines the *transport protocol*
- **OpenC2** is an emerging standard command language enabling interoperability between security orchestration tools from different vendors
- Poor interoperability forces security teams to use "swivel chair" integration — manually copying data between tools, introducing human error and latency
- **SAML, OAuth, and OpenID Connect** enable identity interoperability across different authentication systems and cloud providers
- The **Zero Trust** model *depends* on interoperability — trust decisions require real-time data sharing between identity, endpoint, and network security components

## Related concepts
[[SIEM]] [[STIX/TAXII]] [[Zero Trust Architecture]] [[Federated Identity]] [[Security Orchestration Automation and Response (SOAR)]]