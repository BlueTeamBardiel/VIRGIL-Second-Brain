# Network Troubleshooting Methodology

## What it is

In **Elden Ring**, you walk into Stormveil Castle, get one-shot by a knight you didn't see, and respawn at the Site of Grace. You don't just charge back in swinging. You think: *what hit me?* You check your gear. You watch the room from the doorway. You try a different approach — maybe summon Spirit Ashes, maybe roll right instead of left, maybe come back at level 40 instead of 25. If that knight still wrecks you, you go fight Margit first and come back. You don't randomly mash buttons hoping the boss dies. You form a theory, test it, and if it's wrong you form a new one. That's exactly what network troubleshooting methodology does — it gives you a repeatable seven-step loop so you stop mashing buttons on a broken network and start solving it.

In plain English: when something breaks, you follow the same procedure every time so you don't miss anything and so the next tech can read your ticket and understand what you did. In CompTIA's language: the **CompTIA troubleshooting methodology** is a seven-step structured process used to identify, isolate, resolve, and document network problems in a way that minimizes downtime and prevents recurrence.

## Why it matters

Objective **N10-009 5.1** is the spine of the entire Domain 5.0 troubleshooting section. Every other troubleshooting topic — cable issues, wireless issues, routing problems, performance complaints — gets diagnosed using *this* framework. CompTIA tests the steps in order. They test the names. They test which step you're on when given a scenario. Memorize the seven steps cold.

Career-wise: this is the difference between a junior tech who reboots things until they work and a senior tech who can hand a ticket to a vendor with enough evidence that the vendor doesn't waste another four hours re-asking the same questions. A network is a circulatory system. When it has a heart attack, you don't randomly inject things — you take vitals, form a diagnosis, treat, and chart. Same loop.

## Key facts

### The seven steps (memorize the order)

| # | Step | What you actually do |
|---|---|---|
| 1 | **Identify the problem** | Gather info, question users, identify symptoms, determine what changed, duplicate if possible, approach multiple problems individually |
| 2 | **Establish a theory of probable cause** | Question the obvious. Use OSI top-to-bottom or bottom-to-top, or divide and conquer |
| 3 | **Test the theory** | If confirmed → next step. If not → new theory or escalate |
| 4 | **Establish a plan of action** | Consider multiple approaches, identify potential side effects |
| 5 | **Implement the solution or escalate** | Do the fix, or hand it off with full context |
| 6 | **Verify full system functionality** | Confirm it works AND implement preventive measures if applicable |
| 7 | **Document findings, actions, outcomes, and lessons learned** | Update the ticket, update the runbook |

> **CompTIA exam trap:** "Document" is the **last** step, not an ongoing one — but in practice you document throughout. CompTIA will ask "what is the final step?" and the answer is always **document**. They will also ask "when do you document?" — the answer is **throughout the process**. Both answers can be correct depending on the question stem. Read carefully.

### Step 1 — Identify the problem (the longest step in real life)

This is where most of your time goes. The user said "the internet is broken." That means nothing. You need to convert vibes into evidence.

- **Gather information** — error messages, screenshots, timestamps, affected users, affected services
- **Question users** — what were you doing when it broke? what did you click? did you get a popup?
- **Identify symptoms** — slow vs no connection vs intermittent vs only one app
- **Determine if anything has changed** — recent updates, new hardware, config changes, weather, a new tenant in the building drilling through your cable run
- **Duplicate the problem** — if you can reproduce it on demand, you can fix it. If you can't reproduce it, you're chasing ghosts
- **Approach multiple problems individually** — when a user reports "email is slow AND the printer is offline AND my VPN keeps dropping," those are probably three tickets, not one. Don't conflate them. They might share a root cause, but treat them as separate evidence streams until proven otherwise

*The user is not your enemy, but they are also not a reliable witness. "Nothing changed" means "I didn't change anything I'm willing to admit to."*

### Step 2 — Establish a theory of probable cause

You have symptoms. Now form a hypothesis. CompTIA wants you to know three approaches:

- **Question the obvious** — is it plugged in? is the link light on? is caps lock on the password? is the WAP unplugged because the cleaner needed the outlet? 80% of tickets end here
- **Top-to-bottom OSI** — start at Layer 7 (application) and work down. Useful when the user reports an application problem ("Outlook won't send")
- **Bottom-to-top OSI** — start at Layer 1 (physical) and work up. Useful when the symptoms suggest infrastructure ("nobody on the third floor has internet")
- **Divide and conquer** — start in the middle (Layer 3/4) and move up or down based on what you find. Ping the gateway. If it works, problem is above L3. If it fails, problem is below

> **CompTIA exam trap:** Know when to use each OSI approach. If the question describes an **application-specific** failure ("the CRM won't load but everything else works"), think **top-down**. If the question describes **multiple users with no connectivity** ("the entire floor is dark"), think **bottom-up**. If the question describes a **mixed or unclear** scenario, think **divide and conquer**.

### Step 3 — Test the theory

You have a theory. Now poke it.

- **If the theory is confirmed** → proceed to step 4 (plan of action)
- **If the theory is not confirmed** → either form a new theory (back to step 2) OR escalate to someone with more access, more skills, or more authority

Escalation is not failure. Escalation is recognizing that the problem is outside your scope. The new hire who escalates a BGP peering issue to the network team after 20 minutes of trying to ping is doing it right. The new hire who spends six hours trying to "figure it out" is burning the company's money.

*The ego that won't escalate is the ego that extends outages.*

### Step 4 — Establish a plan of action

Don't just charge in. Especially in production.

- **Consider multiple approaches** — there is almost always more than one way to fix something. Some are fast. Some are clean. Some are reversible. Pick deliberately
- **Identify potential effects** — if you reboot the core switch at 2pm, what breaks? if you change the DHCP scope, who loses their lease? if you push a firewall rule, what legitimate traffic gets blocked?
- **Schedule the change** through change management if the impact warrants it
- **Have a rollback plan** — what do you do if the fix makes it worse?

### Step 5 — Implement the solution or escalate

Execute the plan. If you don't have the access or expertise, escalate with **all the evidence you've gathered** — symptoms, what you tested, what theories you ruled out. A good escalation ticket cuts the next tech's investigation time in half.

### Step 6 — Verify full system functionality

The user says "it's working now." That's not enough. Verify:

- The original symptom is gone
- Related systems still work (you didn't fix the printer by breaking DNS)
- Performance is acceptable, not just "it responds"
- The user can actually do their job

**Implement preventive measures if applicable.** If the outage was caused by a cable getting kicked loose under a desk, add a cable management clip. If it was caused by a DHCP scope exhaustion, expand the scope and add monitoring. The fix is only finished when the same problem can't happen the same way tomorrow.

### Step 7 — Document findings, actions, outcomes, and lessons learned

Update the ticket. Update the runbook. Update the wiki. Future-you, six months from now, will face the same problem and will thank present-you for the breadcrumbs.

- **Findings** — what was the root cause
- **Actions** — what you did
- **Outcomes** — did it work, did it cause side effects
- **Lessons learned** — what would you do differently, what preventive measure was added

> **CompTIA exam trap:** Documentation is not optional and it is not "if I have time." On the exam, if any answer choice says "skip documentation because the issue is resolved," it's wrong. Always.

### The OSI layer cheat for troubleshooting

| Layer | What you check |
|---|---|
| 1 — Physical | Cable plugged in, link light on, correct cable type, distance under 100m for copper |
| 2 — Data Link | MAC address, switch port status, VLAN assignment, STP state |
| 3 — Network | IP address, subnet mask, default gateway, ping, traceroute |
| 4 — Transport | Port reachable, firewall rules, TCP vs UDP, telnet/nc to port |
| 5–7 — Session/Presentation/Application | DNS resolution, TLS handshake, application logs, authentication |

## Helpdesk reality

- User says: **"The internet is down."** What they mean: one website won't load. What you check first: can you ping 8.8.8.8 from their machine? Can you resolve google.com? You just isolated DNS vs routing vs application in 30 seconds
- User says: **"Nothing changed, it just stopped working."** What you do: check the change log anyway. Something always changed. Patch Tuesday was last night. A cert expired at midnight. Someone replaced a switch over the weekend and didn't tell anyone
- Never promise: **"I'll have it fixed in five minutes."** You don't know what it is yet. Promise: "I'll keep you updated every 15 minutes until it's resolved." That's a promise you can keep
- The escalation point: if you've ruled out [[Layer 1]] (cable, link light), [[Layer 2]] (switch port, VLAN), and [[Layer 3]] (IP, gateway, DNS) on the client side and the problem persists, it's a network team ticket. Hand it off with your evidence, not your panic
- **Document while you work, not after.** The ticket you finish at 5:55pm on Friday and "will document Monday" never gets documented. Type as you go

## Related concepts

[[OSI Model]] · [[Cable Testing]] · [[Ping and Traceroute]] · [[Change Management]] · [[Network Documentation]] · [[Wireless Troubleshooting]] · [[DNS Troubleshooting]] · [[DHCP Troubleshooting]] · [[Layer 1 Issues]] · [[Common Network Issues]] · [[Show Commands]] · [[Packet Capture]]

*Source: VIRGIL knowledge base — 2026-05-11*