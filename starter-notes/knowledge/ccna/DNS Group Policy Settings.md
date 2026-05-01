# DNS Group Policy Settings

## What it is
Like a traffic cop who can redirect cars to different streets regardless of where drivers *think* they're going, DNS Group Policy Settings let administrators enforce DNS behavior across all domain-joined machines through Active Directory. Specifically, these are GPO-configured rules that control DNS client behavior — including which servers to query, how to handle suffix searches, and whether DNS over HTTPS (DoH) is permitted — applied uniformly across an enterprise.

## Why it matters
During a supply chain attack, an adversary who compromises a DNS server can redirect internal clients to malicious infrastructure. By enforcing DNS Group Policy Settings that pin clients to known-good, monitored internal resolvers and block direct external DNS queries (port 53 outbound), defenders can contain DNS hijacking and ensure all queries flow through logging infrastructure — giving the SOC visibility into C2 beaconing via DNS tunneling.

## Key facts
- GPOs can configure `DNS over HTTPS (DoH)` via **Computer Configuration → Administrative Templates → Network → DNS Client**, allowing orgs to either mandate or prohibit encrypted DNS
- The **"DNS Servers"** policy setting overrides DHCP-assigned DNS, ensuring endpoints always query approved resolvers even on rogue networks
- **DNS suffix search lists** set via GPO prevent employees from accidentally resolving short hostnames against attacker-controlled external domains
- Disabling **DNS multicast (mDNS/LLMNR)** through GPO eliminates the attack surface exploited by tools like Responder for credential harvesting
- Group Policy DNS settings are found under `HKLM\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient` in the registry

## Related concepts
[[DNS Hijacking]] [[LLMNR Poisoning]] [[DNS over HTTPS]] [[Active Directory Group Policy]] [[DNS Tunneling]]
