# Network Tools

## What it is

You're at 2am, the homelab Plex server stopped streaming, and SSH into the box still works. That tells you something already — the network stack's voice and ears are partially alive. Now you need the tools to figure out *which* part is dead. DNS? Routing? The interface itself? A firewall rule that updated when you weren't looking?

Network tools are the diagnostic kit for the machine's nervous connection to the outside world. In Linux, they're command-line utilities that let you inspect interfaces, test reachability, resolve names, trace paths, and pull data from remote servers. They're also on the A+ Core 1 exam under Objective 1.9 because every Linux admin — and every helpdesk tech who touches a Linux box — uses them weekly.

Technically: a small set of binaries (`ip`, `ping`, `traceroute`, `dig`, `curl`) and configuration files (`/etc/hosts`, `/etc/resolv.conf`) that together expose the kernel's networking subsystem to the operator. You learn five commands and you can diagnose 90% of network problems on any Linux system.

## Why it matters

Networking issues are the #1 ticket category in any IT shop after "I forgot my password." Knowing which tool to reach for — and in what order — is the difference between a 5-minute fix and a 2-hour rabbit hole. CompTIA tests this directly on 220-1201 Objective 1.9: they will give you a symptom and four command options, and you pick the right one.

Beyond the exam, this is the foundation for everything network-adjacent: Linux server admin, container troubleshooting, cloud (AWS/Azure VMs are Linux by default), security work (every pen test starts with `ping` and `dig`), and homelab survival. The tools are universal — same `ip` command on Ubuntu, RHEL, Alpine, Arch, the Raspberry Pi running Pi-hole, the router running OpenWrt.

## In your build, in the enterprise

**Beat 1 — The toolkit.** Five commands carry the load. `ip` replaced the old `ifconfig` years ago — it shows interfaces, addresses, routes, and the ARP table. `ping` sends ICMP echo requests to test reachability. `traceroute` maps the hop-by-hop path to a destination, exposing where packets die. `dig` queries DNS directly — bypassing the resolver cache, hitting whichever nameserver you point it at. `curl` makes HTTP(S) requests from the command line, perfect for testing whether a web service is actually responding versus just being pingable. Behind these tools sit two config files: `/etc/hosts` (local hostname-to-IP overrides, checked before DNS) and `/etc/resolv.conf` (which DNS servers the system asks). Know the tool, know the file it reads from, know what layer of the stack you're testing.

**Beat 2 — Feynman: the homelab Plex outage.**

**Step 1 — Is the interface alive?** SSH worked, so probably yes, but verify: `ip a` (short for `ip address`). You see `eth0` is `UP`, has `192.168.1.50/24`. *Layer 1 and 2 are fine.*

**Step 2 — Can it reach the gateway?** `ping 192.168.1.1`. Replies come back in 0.4ms. *Local network is healthy.*

**Step 3 — Can it reach the internet?** `ping 1.1.1.1`. Replies. *Routing out is fine.*

**Step 4 — Can it resolve names?** `ping google.com`. "Name or service not known." Found it. The interface is up, routing works, but DNS is broken.

**Step 5 — Why is DNS broken?** `cat /etc/resolv.conf`. The file is empty. Some update or NetworkManager hiccup wiped it. Add `nameserver 1.1.1.1`, save, retest. Plex starts streaming. *Total time: 4 minutes. The tools told the story.*

**Beat 3 — Bridge from homelab to enterprise.** Same diagnostic flow on a production web server that "stopped responding." Step 1: `ip a` — interface up. Step 2: `ping` the gateway — works. Step 3: `ping` an external IP — times out. Now you know: the box can't egress. On a homelab, that means check your router. In the enterprise, that means: is there an outbound firewall rule? A new security group on the cloud VM? Did the network team change the upstream router config during the maintenance window you didn't read the email about? Same tools, same flow, different ecosystem of who-broke-what.

**Beat 4 — The point.** Network troubleshooting is a layered question — *am I physically connected, am I addressed, am I routed, can I resolve, can I reach the application?* Five questions, five tools, asked in order. Get this sequence into your bones and you'll solve network tickets faster than people who've been doing this for ten years but never learned to be systematic.

## Key facts

### The core commands

| Command | What it does | Common flags |
|---|---|---|
| `ip a` | Show all network interfaces and their addresses | `ip a` (short for `ip address`) |
| `ip r` | Show routing table | `ip r` (short for `ip route`) |
| `ping <host>` | ICMP echo to test reachability | `-c 4` to send 4 packets and stop |
| `traceroute <host>` | Show the path packets take, hop by hop | `-n` to skip DNS lookups (faster) |
| `dig <host>` | Query DNS directly | `dig @1.1.1.1 google.com` to specify nameserver |
| `curl <url>` | Make HTTP request | `-I` for headers only, `-v` for verbose |

Older systems may still have `ifconfig`, `route`, and `nslookup` — they work but they're deprecated. CompTIA may test the legacy names; in the field, use the modern ones.

### Configuration files

| File | Purpose |
|---|---|
| `/etc/hosts` | Static hostname-to-IP mappings. Checked **before** DNS. |
| `/etc/resolv.conf` | Lists DNS servers (`nameserver 1.1.1.1`). |
| `/etc/fstab` | Filesystem mount table — not network, but exam-tested in this objective. |
| `/etc/passwd` | User account database (no passwords, despite the name). |
| `/etc/shadow` | Hashed passwords. Root-readable only. |

### The diagnostic ladder

When something can't reach something else, work the layers in order:

1. **Interface** — `ip a` — is the NIC up and addressed?
2. **Local network** — `ping <gateway>` — can you reach your own router?
3. **Internet routing** — `ping 1.1.1.1` — can you reach a known-good external IP?
4. **DNS** — `ping google.com` or `dig google.com` — can you resolve names?
5. **Application** — `curl https://service.example.com` — does the actual service respond?

If step 3 works and step 4 fails, it's DNS. (It's always DNS.)

### CompTIA exam traps

> **CompTIA exam trap:** `ping` vs `traceroute` — `ping` tells you *if* a host is reachable; `traceroute` tells you *where* the path breaks. If the question says "identify the failing hop," that's `traceroute`. If it says "verify connectivity," that's `ping`.

> **CompTIA exam trap:** `dig` vs `nslookup` — both query DNS. CompTIA prefers `dig` as the modern Linux answer; `nslookup` is the legacy/Windows answer. If the question is Linux-flavored, pick `dig`.

> **CompTIA exam trap:** `/etc/hosts` is read **before** DNS. If a hostname resolves to the wrong IP and `dig` shows the right one, check `/etc/hosts` for a stale entry.

> **CompTIA exam trap:** `curl` vs `ping` — a host can be pingable but the web service down (port 443 blocked, web server crashed). `ping` tests ICMP at Layer 3; `curl` tests the actual application at Layer 7. They answer different questions.

## At home, at the helpdesk

The homelab use case is straightforward — you own the box, you run the commands, you fix the problem. In the enterprise, the same tools work but the context shifts:

- **You may not have root.** Most Linux network commands work without sudo (`ip a`, `ping`, `dig`, `curl`, `traceroute`). Editing `/etc/resolv.conf` requires sudo. The exam loves this distinction — read-only diagnostic tools rarely need elevation; modifying config files always does.
- **Configuration is managed, not edited.** On a production server, you don't `nano /etc/resolv.conf` — that change gets overwritten by NetworkManager, systemd-resolved, cloud-init, or Ansible the next time something runs. You file a ticket with the team that owns the configuration management system, or you make the change in the right tool. *Hand-editing config files on production servers is how outages start.*
- **Logs replace eyeballs.** At home you watch ping output in real time. In production, you check `journalctl -u NetworkManager` or whatever the service log is, because the failure happened at 3am and nobody saw it.

## Helpdesk reality

- **"The internet is slow."** Translation: something between their browser and the destination is slow, and they don't know which. Run `ping` to the gateway (rules out local Wi-Fi), then `ping 1.1.1.1` (rules out ISP), then `traceroute` to the destination they care about. The slow hop tells you where to escalate.
- **"This website won't load but others work."** Either DNS for that specific site is broken (check `dig`), the site itself is down (check from a different network — `curl` from a cloud VM), or your firewall blocked it. *Don't assume the user's machine is broken until you've ruled out the destination.*
- **"I can ping the server but I can't connect."** Classic Layer 7 issue. The host is alive, the application isn't. Check the service status, check the firewall for that specific port, check `curl` to confirm what's actually listening.
- **Never promise "it'll be fixed in X minutes" on a network issue.** You don't know yet whether it's a misconfigured `/etc/resolv.conf` (2-minute fix) or a BGP route problem at the ISP (4-hour fix). Promise diagnosis, not resolution.
- **Document the commands you ran in the ticket.** "Ran `ping`, `traceroute`, `dig` — DNS resolution failed; `/etc/resolv.conf` was empty; restored nameserver entries; verified with `dig google.com`." That's a ticket the next tech can learn from.

## Related concepts

[[Linux File Management]] · [[Linux Permissions and Ownership]] · [[Linux Package Management]] · [[Linux Common Configuration Files]] · [[DNS Fundamentals]] · [[TCP IP Networking Basics]] · [[Network Troubleshooting Methodology]]

*Source: VIRGIL knowledge base — 2026-05-10*