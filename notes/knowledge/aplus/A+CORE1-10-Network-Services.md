# Network Services

## What it is

Your home network has maybe three things on it that count as "services": the router doing DHCP, the router doing DNS forwarding, and your printer being shared. Spin up a homelab and suddenly you're running a Pi-hole, a Plex server, a Syslog collector, an NTP source, and a reverse proxy. Walk into an enterprise and that list explodes into dozens of dedicated servers, each doing one job, each with redundancy, monitoring, and a 3 AM on-call rotation attached.

In plain English: a network service is software running on a host that other devices reach across the network to get something done. You don't go to it physically — you query it over a port.

Technical definition: a network service is a process bound to one or more transport-layer ports on a host (server, appliance, or embedded device), accepting requests from clients via standardized protocols. Services are categorized by role (what they do), placement (LAN-internal vs DMZ vs cloud), and ownership (general-purpose server vs purpose-built appliance vs embedded firmware).

## Why it matters

Every troubleshooting ticket eventually traces back to a service: DNS didn't resolve, DHCP didn't hand out a lease, the print server queue jammed, the proxy blocked the URL, the mail gateway quarantined the attachment. If you can't name the services on a network and what each one does, you can't troubleshoot the network — you can only restart things and hope.

Objective 220-1201 2.3 tests whether you recognize service roles by name and function. CompTIA loves to give you a symptom and ask which service is responsible. "Users can ping IPs but not browse by name" → DNS. "New laptops aren't getting addresses" → DHCP. "Logs from twelve switches need to land in one place" → Syslog. Memorize the mapping or lose easy points.

## In your build, in the enterprise

**Beat 1 — technical depth.** Network services divide into three rough buckets the exam cares about. **Server roles** are general-purpose OS installs (Windows Server, Linux) running one or more services: file, print, web, database, mail, DNS, DHCP, authentication. **Internet appliances** are purpose-built boxes — sometimes physical, sometimes virtual — that do one thing well: load balancers (F5, HAProxy), UTM firewalls (Fortinet, Palo Alto), spam gateways (Proofpoint, Mimecast), proxies (Squid, Zscaler), syslog collectors (Graylog, Splunk forwarders). **Legacy and embedded systems** are the things running on hardware older than the intern: SCADA controllers in a water plant, an embedded web server on a 2008 HVAC controller, a database server nobody's patched since the original admin retired. IoT devices are the new embedded — smart thermostats, cameras, sensors — usually phoning home over MQTT or HTTPS, often relying on NTP to keep their cert validation honest.

**Beat 2 — Feynman example via homelab.**

**The DNS moment:** You stand up Pi-hole on a Raspberry Pi to block ads network-wide. Point your router's DHCP to hand out the Pi as the DNS server. Suddenly every device on your LAN — phone, TV, console — queries the Pi first. *DNS isn't a website lookup tool. It's the phonebook every connected device hits before it does anything.*

**The DHCP moment:** You disable the router's DHCP and let a Windows Server VM hand out leases instead, with reservations for your NAS and printer. A laptop boots, broadcasts DISCOVER, gets OFFER, sends REQUEST, receives ACK. Four packets, every device, every boot. *DHCP is the doorman. No lease, no party.*

**The fileshare moment:** You spin up a TrueNAS box, share `/media` over SMB, mount it on every machine. Plex reads from it. Your laptop writes to it. Your phone backs up photos to it. *A fileshare is the family fridge — everybody pulls from it, everybody puts back, and one person inevitably leaves something rotting in there.*

**The kicker:** You add a reverse proxy (Nginx Proxy Manager) so `plex.home.lan` and `nas.home.lan` resolve to the right boxes on the right ports. Now you're running six services across three machines, and you're already touching DNS, DHCP, fileshare, web, proxy, and the cert renewal job behind it. *That's a homelab. The enterprise version is the same picture, multiplied by 500 and with auditors watching.*

**Beat 3 — bridge to enterprise.** Your homelab Pi-hole becomes a redundant pair of Windows DNS servers backing Active Directory, with conditional forwarders to Azure DNS, secured with DNSSEC. Your single DHCP scope becomes 40 VLAN-scoped pools with reservations enforced by MAC, failover-paired so a single server reboot doesn't dark the building. Your TrueNAS share becomes a clustered file server with DFS namespaces, snapshots, and tape rotation. Your Nginx proxy becomes an F5 load balancer with health checks, SSL offload, and geographic failover. Same fundamental services. Different blast radius when one goes down.

**Beat 4 — the point.** Same fundamental question — what service answers this request, and what happens when it doesn't? — different scale, different right answers. At home, "DNS is broken" means edit `/etc/resolv.conf`. In the enterprise, it means a P1 ticket, a war room, and a postmortem. *Get the service-name-to-symptom mapping into your bones. The exam tests it. The job demands it.*

## Key facts

### Server roles (general-purpose hosts running services)

| Role | What it does | Default ports |
|---|---|---|
| **DNS server** | Name-to-IP resolution | 53/UDP, 53/TCP |
| **DHCP server** | Hands out IP leases, gateway, DNS info | 67/68 UDP |
| **File server** | SMB/NFS shares for users and apps | 445 (SMB), 2049 (NFS) |
| **Print server** | Manages print queues, drivers, ACLs | 9100 (raw), 631 (IPP) |
| **Web server** | Serves HTTP/HTTPS content | 80, 443 |
| **Mail server** | Sends/receives email (SMTP/IMAP/POP) | 25, 587, 465, 143, 993, 110, 995 |
| **Database server** | Stores structured data for apps | 1433 (MSSQL), 3306 (MySQL), 5432 (Postgres) |
| **Authentication server** | AD DC, LDAP, RADIUS, TACACS+ | 389, 636, 1812, 49 |

### Internet appliances (purpose-built boxes)

- **DNS** — caching/resolving or authoritative; large orgs run both internally and at the edge
- **DHCP** — usually a server role, but enterprise routers and firewalls can do it for small sites
- **Spam gateway** — sits in front of the mail server, filters phishing/malware/spam before delivery (Proofpoint, Mimecast, Barracuda)
- **UTM (Unified Threat Management)** — firewall + IDS/IPS + AV + content filter + VPN in one appliance; common at SMB sites
- **Fileshare appliance** — NAS (Synology, QNAP, NetApp) — purpose-built file server with its own OS
- **Load balancer** — distributes incoming traffic across multiple backend servers; health-checks, SSL offload, sticky sessions (F5, Citrix ADC, HAProxy, Nginx)
- **Print server** — can be a Windows server role or a dedicated appliance like a PaperCut box
- **Proxy server** — sits between clients and the internet; caches, filters, logs, enforces policy (Squid, Zscaler, Blue Coat)
- **Mail server** — Exchange, Postfix, Microsoft 365 / Exchange Online — increasingly cloud-hosted
- **Syslog server** — central log collector; every switch, router, firewall, and server forwards events to it (Graylog, Splunk, ELK, rsyslog)

### Legacy and embedded systems

- **Legacy web servers** — old IIS 6 boxes, ancient Apache instances on RHEL 5 — often running a vendor app that "can't be upgraded." Air-gap them or wrap them in a reverse proxy.
- **SCADA (Supervisory Control and Data Acquisition)** — industrial control systems for water, power, manufacturing. Runs on protocols like Modbus, DNP3. Almost never patched. Lives on a segregated OT network. Touch one with the wrong tool and a turbine spins down.
- **Embedded web servers** — printers, IP cameras, KVMs, building HVAC controllers — all have tiny web UIs running on busybox or a vendor RTOS. Default creds are the industry's worst-kept secret.

### IoT devices

- **Database servers in IoT context** — many IoT platforms ingest sensor data into time-series databases (InfluxDB, Timescale). Don't expose 5432 or 8086 to the internet. Ever.
- **NTP (Network Time Protocol, port 123/UDP)** — keeps clocks synchronized. Critical for log correlation, Kerberos auth (5-minute skew window), TLS cert validation, and IoT devices that brick themselves when their clock drifts.

### CompTIA exam traps

> **Exam trap:** DNS vs DHCP confusion. DHCP hands out *the address of* the DNS server in option 6. DNS does not assign IPs. If users can ping `8.8.8.8` but not `google.com`, that's DNS. If users have no IP at all (169.254.x.x APIPA), that's DHCP.

> **Exam trap:** UTM vs firewall. A plain firewall does Layer 3/4 filtering. A UTM bundles firewall + IPS + AV + content filtering + VPN. CompTIA wants you to recognize UTM as the "all-in-one box" for SMB.

> **Exam trap:** Proxy vs load balancer. A proxy sits between clients and the internet (forward proxy) or in front of servers (reverse proxy) — it filters, caches, logs. A load balancer distributes traffic across backends for scale and availability. Reverse proxies and load balancers overlap in modern appliances; CompTIA still treats them as distinct concepts.

> **Exam trap:** Syslog is UDP 514 by default. Logs sent over UDP can be lost silently. Production deployments use TCP 6514 with TLS. The exam still expects 514/UDP as the default answer.

> **Exam trap:** NTP skew breaks Kerberos. If a client's clock drifts more than 5 minutes from the domain controller, AD authentication fails. Symptom: "I can't log in but my coworker can." Check the clock.

## Helpdesk reality

- "The internet is down" → 80% of the time it's DNS. Ping `8.8.8.8` first. If that works, it's name resolution. `nslookup` or `Resolve-DnsName` from the user's machine.
- "I can't print" → check the print server queue, then the spooler service on the user's machine (`net stop spooler && net start spooler`), then the printer's network connection. In that order.
- "Email isn't sending" → check the mail server status page first, then the spam gateway quarantine, then the user's outbox. Don't promise delivery times — mail can sit in transit queues for hours legitimately.
- "I keep getting kicked off the VPN" → could be the UTM, could be a flaky ISP, could be the user's home router dropping UDP. Get the timestamps and check the firewall logs against them.
- A user calls about a "weird device on the network" — that's an IoT thing somebody plugged in without telling anyone. Smart TV, smart fridge, conference room sensor. They proliferate. Inventory them or they'll bite you during an audit.

## Related concepts

[[TCP and UDP Ports]] · [[DNS]] · [[DHCP]] · [[Active Directory]] · [[Firewalls and UTM]] · [[Load Balancing and High Availability]] · [[SOHO Networking]] · [[Syslog and SIEM]] · [[NTP and Time Sync]] · [[IoT Security]] · [[SCADA and OT Networks]]

*Source: VIRGIL knowledge base — 2026-05-10*