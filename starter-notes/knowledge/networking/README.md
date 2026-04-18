# Networking Knowledge Notes

Notes on networking protocols, configurations, lab exercises, and study materials. Populated by `virgil-pdf` and `virgil-url`.

## Getting Started

```bash
# Ingest a networking textbook (large PDFs chunk automatically)
virgil-pdf ~/Downloads/networking-guide.pdf networking

# Ingest protocol documentation or a vendor page
virgil-url https://example.com/bgp-guide "BGP routing"
```

## Concepts Worth Understanding Early

If you're studying for CCNA, Network+, or any security cert that touches networking — these are the concepts that appear everywhere. Ingest or write a note for each when you study it:

- **IP addressing and subnetting** — you will be asked to subnet by hand
- **OSI and TCP/IP models** — know which protocols live at which layer
- **TCP vs UDP** — when each is used and why
- **DNS** — how resolution works, common record types (A, AAAA, MX, CNAME, PTR)
- **DHCP** — the DORA process, scope, lease
- **NAT/PAT** — how private IPs reach the internet
- **VLANs and trunking** — how switches segment traffic
- **Routing basics** — static routes, default gateway, when a router decides to forward
- **Firewalls and ACLs** — stateful vs stateless, how rules are evaluated
- **TLS/SSL** — what the handshake actually does, why certificates matter

## For CCNA Candidates

The Cisco Official Cert Guide (Vol 1 and Vol 2) is the standard reference. Run `virgil-pdf` on each volume — large PDFs are chunked and synthesized automatically. Once ingested, use `virgil-url` on any topic you want to drill deeper.

## Tags

#networking #knowledge-base #ccna
