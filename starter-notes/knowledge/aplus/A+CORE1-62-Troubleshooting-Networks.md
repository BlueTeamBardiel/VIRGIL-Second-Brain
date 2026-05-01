---
tags: [knowledge, aplus, core-1-(220-1201)]
created: 2026-04-30
cert: CompTIA A+
chapter: 62
source: rewritten
---

# Troubleshooting Networks
**Master the logical troubleshooting sequence to isolate connectivity issues from hardware to software.**

---

## Overview

Network troubleshooting is like detective work—you gather evidence systematically to pinpoint where the problem lives. For the A+ exam, you need to know the *order* of checks: physical indicators first, then internal system health, then local connectivity, then external reach. This separates actual breaks from misconfigurations and saves you from replacing hardware that isn't broken.

---

## Key Concepts

### Link Light Verification

**Analogy**: The link light is like checking if your car's engine is actually running before you blame the transmission. You see smoke from the tailpipe? Good—*something* is happening under the hood.

**Definition**: A [[physical indicator light]] on an [[Ethernet port]] that blinks or glows steady, confirming that an [[NIC|network interface card]] has established a connection to the network device on the other end (typically a [[switch]] or [[router]]).

- **Light ON** = Physical layer connectivity exists
- **Light OFF** = Cable issue, port failure, or device unplugged
- **Blinking** = Active data transmission

| Scenario | Link Light | Issue |
|----------|-----------|-------|
| Good wired connection | Steady/blinking | Proceed to next step |
| Unplugged cable | OFF | Replace/reseat cable |
| Bad [[RJ-45]] connector | OFF | Test cable integrity |
| NIC failure | OFF | Replace NIC or device |

**First thing to check**—don't skip this. It's free information.

---

### Loopback Address Testing

**Analogy**: Pinging 127.0.0.1 is like calling your own phone number—if *you* don't answer yourself, your phone isn't working at all. You're not testing the network; you're testing your own hardware's ability to talk to itself.

**Definition**: The [[loopback address]] (127.0.0.1 in [[IPv4]]) is a special reserved address that routes packets back to the sending device without touching the physical network. It validates that the [[TCP/IP stack]] on your operating system is functional.

```bash
ping 127.0.0.1
```

**What it tells you**:
- ✅ Response received = Your [[NIC driver]], network layer, and OS are healthy
- ❌ No response = Corrupted [[network stack]], disabled NIC driver, or software firewall blocking loopback

**Critical**: If loopback fails, the network card or drivers are broken—not the cable.

---

### Local IP Address Ping

**Analogy**: Testing your assigned IP address (like 192.168.1.50) is like checking that your mailbox has your name on it and mail carrier recognizes it. The loopback proved the mailbox exists; this proves *your* address works in the real world.

**Definition**: Pinging the device's own [[IPv4 address|IP address]] (whether assigned by [[DHCP]] or statically configured) confirms that the [[NIC]] can communicate on the local network segment and that the [[IP configuration]] is valid.

```bash
ping 192.168.1.50  # (example: your device's IP)
```

**Success criteria**:
- Replies received with reasonable latency
- Confirms [[ARP resolution]] is working
- Proves the device exists on the network logically

| Source | Assignment Method | Check For |
|--------|-------------------|-----------|
| [[DHCP server]] | Automatic | IP in correct subnet range |
| Static/Manual | Configured by admin | No conflict with other devices |

**Before you ping the local IP**, verify with `ipconfig` ([[Windows]]) or `ifconfig` ([[Linux]]) that you actually have an address.

---

### Default Gateway Testing

**Analogy**: Your default [[gateway]] is like the front gate of your neighborhood. If you can reach the gate, you know the road out of the neighborhood exists. If you can't reach it, you're isolated no matter what happens beyond it.

**Definition**: The [[default gateway]] is the [[router]] address (typically 192.168.1.1 on home networks or 10.0.0.1 in enterprise) that serves as the exit point for traffic headed to remote networks. Pinging it confirms local network infrastructure and the route to networks beyond your subnet.

```bash
ping 192.168.1.1  # (example: common gateway address)
ipconfig /all     # (Windows — view your gateway)
route -n          # (Linux — view routing table)
```

**What success means**:
- Router is powered on and reachable
- Your device's local network segment works
- Subnet mask and gateway configuration are correct

| Result | Interpretation |
|--------|-----------------|
| Gateway responds | Local network infrastructure OK |
| Gateway no response | Router down, subnet misconfigured, or device isolated |
| Timeout with 100% loss | Device can't reach local segment (bad gateway entry) |

---

## Exam Tips

### Question Type 1: Layered Troubleshooting Sequence
- *"A user reports no internet. You see the link light is ON. What should you check next?"* → **Ping the loopback address** (127.0.0.1) to confirm the network stack works locally before blaming external connectivity
- *"Loopback ping succeeds but pinging the device's own IP fails. What's the issue?"* → **[[DHCP]] failure or IP configuration error**—the NIC is fine, but the address isn't assigned
- **Trick**: Students jump straight to "reset the router" without checking the device's own address first. The exam rewards methodical isolation.

### Question Type 2: Link Light Absence
- *"A desktop has no network connectivity and the link light on the NIC is off. Which is the LEAST likely cause?"* → **Outdated network driver** (would still show a light if hardware is present) vs. **disconnected cable** (correct—no light)
- **Trick**: Confusing "no link light" with "network driver issue." A bad driver still illuminates the link light if the hardware detects carrier signal.

---

## Common Mistakes

### Mistake 1: Skipping the Link Light
**Wrong**: "The computer won't connect to the network, so I'll immediately reinstall the driver."
**Right**: Check the physical link light first. If it's off, the problem is hardware or cable—no driver reinstall will help.
**Impact on Exam**: You'll pick "update NIC drivers" when the answer is "replace the Ethernet cable." Physical beats logical.

### Mistake 2: Testing External Before Testing Local
**Wrong**: "I can't reach Google, so my internet is broken."
**Right**: Ping your gateway first. If that fails, your ISP isn't the problem—your local network is.
**Impact on Exam**: A question might say "user can't reach external sites but can ping the gateway." The issue is [[DNS]] or [[firewall]], not connectivity. Test in order: loopback → local IP → gateway → external.

### Mistake 3: Confusing Loopback with Actual Network Connectivity
**Wrong**: "I pinged 127.0.0.1 successfully, so the network is working."
**Right**: Loopback only proves your *device's* software stack is healthy. You still need to ping your actual IP, then the gateway.
**Impact on Exam**: Don't mistake a passing loopback test as proof of network connectivity. Loopback = local health check only.

### Mistake 4: Not Checking IP Configuration Before Pinging Local Address
**Wrong**: Ping 192.168.1.50 without verifying that 192.168.1.50 is actually your device's address.
**Right**: Run `ipconfig` first to see what address (if any) is assigned, then ping that.
**Impact on Exam**: You might ping the wrong address and blame the network when your device simply has no IP assigned.

---

## Related Topics
- [[Physical Layer Troubleshooting]]
- [[TCP/IP Stack]]
- [[DHCP Troubleshooting]]
- [[Default Gateway]]
- [[IPv4 Addressing]]
- [[Ping Command]]
- [[Network Interface Card (NIC)]]
- [[Ethernet]]
- [[DNS Troubleshooting]]
- [[Firewall Rules]]

---

*Source: Professor Messer CompTIA A+ Core 1 (220-1201) | [[A+]]*