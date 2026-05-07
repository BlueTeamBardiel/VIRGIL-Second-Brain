# Syslog

## What it is

Every kill, death, assist, and objective capture in a match gets recorded somewhere — and if you've ever pulled up the post-game scoreboard in Call of Duty, you've used the same idea Syslog runs on. Syslog is the protocol network devices use to ship log messages to a central server so you can see what happened, when it happened, and how bad it was, all in one place instead of SSH-ing into thirty switches at 3am.

It's defined in RFC 3164 (the original) and RFC 5424 (the cleaner modern version), and by default it rides UDP port 514. UDP because logs are high-volume and fire-and-forget — like spray-and-pray with an LMG, you'd rather lose a message than slow the whole device down waiting for ACKs.

A Syslog message is a structured little packet of text containing:
- **Priority** (severity + facility, encoded as a number)
- **Timestamp**
- **Hostname** (which device sent it)
- **Tag / process identifier** (what subsystem on the device)
- **Message body** (the actual event text)

## Why it matters

Without centralized logging, troubleshooting is like trying to review a Counter-Strike 2 round from the perspective of just one player — you only see your slice of reality. With Syslog feeding a central collector, you get the full demo: every router, switch, and firewall narrating events on a shared timeline. Correlating an outage across devices becomes possible instead of forensic guesswork.

It also matters because devices generate a *lot* of noise. Syslog's severity system lets you tune the volume knob — send only the screaming-fire messages to the central server, keep the chatty stuff in a local buffer, and ignore debug spam unless you specifically ask for it.

## Key facts

### The 8 severity levels (0 = worst, 7 = whatever)

Think of it like Elden Ring boss tiers — level 0 is Malenia at full HP in your face, level 7 is a rat in Stormveil:

| Level | Name | Vibe |
|---|---|---|
| 0 | Emergency | System is unusable. The server room is on fire. |
| 1 | Alert | Act now. Take immediate action. |
| 2 | Critical | Critical condition. Something major broke. |
| 3 | Error | An error occurred but the device is still standing. |
| 4 | Warning | Heads up, this could become a problem. |
| 5 | Notice | Normal but significant. Worth noticing. |
| 6 | Informational | Routine status updates. |
| 7 | Debug | Verbose dev-mode output. |

**Higher number = lower urgency.** Counterintuitive, like how lower ping is better.

### Configuring what gets sent where

`logging trap` is the bouncer at the door — it sets the minimum severity that gets sent to the Syslog server. Anything above the threshold (less urgent) gets turned away.

- `logging trap emergencies` → level 0 only
- `logging trap errors` → levels 0–3
- `logging trap warnings` → levels 0–4
- `logging trap informational` → levels 0–6
- `logging trap debug` → levels 0–7 (the firehose)

Other relevant commands:
- `logging 10.0.0.50` — points the device at a Syslog server. You can configure multiple for redundancy, like having backup Discord servers in case one goes down.
- `logging console` — pipes messages to the console terminal.
- `logging buffered <bytes>` — creates a circular buffer in RAM. When it fills up, oldest messages get overwritten, just like the killcam history in Apex Legends only keeps the recent stuff.
- `logging synchronous` — stops log messages from interrupting your CLI typing. Without it, a log line can spawn mid-command and shred your input like lag mid-combo.
- `show logging` — displays the local buffer contents and current logging config.

### Making logs more readable

- `service timestamps log datetime msec` — adds millisecond-precision timestamps. When you're correlating a flap across devices, "14:02:31.847" beats "14:02:31" every time.
- `service sequence-numbers` — prepends a sequence number to each message, so you can tell if any got dropped (remember, UDP).

### Debugging — handle with care

- `debug <something>` — turns on real-time diagnostic output for a specific feature. This is the developer console of network gear.
- `undebug all` (or `no debug all`) — kills all debug output. Memorize this. Seriously.
- Debug eats CPU cycles. Running it on a production router is like running RTX path tracing on a potato — the device can choke.
- **Never run debug on a remote SSH session without `logging synchronous` and a plan.** The debug output floods your own session, you can't type fast enough to turn it off, and you've just DoS'd yourself.

### Syslog vs. SNMP vs. NetFlow

Three different tools for three different jobs — like the recon, support, and assault classes in a squad shooter:

| Protocol | Port | What it does |
|---|---|---|
| Syslog | UDP 514 | Device → server, text events and alerts. One-way reporting. |
| SNMP | UDP 161/162 | Bidirectional. Server can poll devices (161) and devices can send traps (162). |
| NetFlow | UDP 2055 | Flow statistics and traffic analysis — who talked to whom, how much, how long. |

Syslog tells you *what happened*. SNMP lets you *ask and configure*. NetFlow tells you *who's talking to whom and how much bandwidth they're burning*.

## Related concepts

[[SNMP]]
[[NetFlow]]
[[NTP]]
[[UDP]]
[[Network Management]]
[[Logging Levels]]
[[SIEM]]
[[Cisco IOS CLI]]