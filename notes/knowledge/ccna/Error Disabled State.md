# Error Disabled State

## What it is

In Assassin's Creed, break the Creed by killing a civilian or getting spotted too many times and the Animus desynchronizes — the simulation yanks you out and refuses to continue until you reload. That's exactly what **err-disabled** does — a switch port violates its rules, so the switch desyncs the port and refuses to forward traffic until someone fixes it.

**Err-disabled** is an administrative state where Cisco IOS automatically disables a Layer 2 interface after detecting a configured violation, taking the port down until manual intervention or timer-based recovery occurs.

## Why it matters

A single misbehaving device — a rogue switch plugged into an access port, a chatty unauthorized MAC, a flapping fiber — can take down production ports without warning. If you don't know how to read err-disabled or recover from it, you'll spend an outage staring at a "down/down" port that looks identical to a cable problem but isn't. On the CCNA, expect to identify the cause from `show` output and pick the correct recovery command.

## Key facts

### Common causes

| Cause | Triggered by |
|---|---|
| **bpduguard** | A [[BPDU]] arrives on a port with [[BPDU Guard]] enabled (usually a [[PortFast]] access port) |
| **psecure-violation** | [[Port Security]] sees more MACs than `maximum`, or an unknown MAC in `sticky`/`static` mode |
| **udld** | [[UDLD]] detects a unidirectional fiber link in aggressive mode |
| **link-flap** | Port goes up/down more than **5 times in 10 seconds** (default) |
| **dtp-flap, l2ptguard, loopback, security-violation** | Various other [[Layer 2]] sins |

### Detecting it

```
Switch# show interfaces status err-disabled
Port      Name      Status                Reason            Err-disabled Vlans
Gi0/1               err-disabled          bpduguard
```

```
Switch# show interfaces gi0/1
GigabitEthernet0/1 is down, line protocol is down (err-disabled)
```

The clue is the parenthetical `(err-disabled)` — without it, "down/down" just means cable or shutdown.

### Manual recovery

The classic shut/no shut, performed by a human who has presumably fixed the underlying problem:

```
Switch(config)# interface gi0/1
Switch(config-if)# shutdown
Switch(config-if)# no shutdown
```

If you `no shut` without `shut` first, nothing happens. The port is stuck in err-disabled and ignores polite requests.

### Automatic recovery

Enable per-cause timers so the port resurrects itself:

```
Switch(config)# errdisable recovery cause bpduguard
Switch(config)# errdisable recovery cause psecure-violation
Switch(config)# errdisable recovery interval 300
```

- **Default interval**: `300` seconds (5 minutes)
- **Range**: 30 to 86400 seconds
- Each cause must be enabled individually, or use `cause all`

Verify:

```
Switch# show errdisable recovery
ErrDisable Reason      Timer Status
-----------------      --------------
bpduguard              Enabled
psecure-violation      Enabled
...
Timer interval: 300 seconds
```

### Why the timer exists

Without a delay, a port that flapped once would flap forever — recover, re-trigger, recover, re-trigger, in a tight loop that floods logs and destabilizes [[Spanning Tree Protocol]]. The interval gives the offending device time to either stop misbehaving or get unplugged by someone who's noticed. Auto-recovery is a convenience; it is not a fix. If the cause is still present, the port will err-disable again on the next violation.

### Exam-trap subtleties

- BPDU Guard putting the port in err-disabled is the **whole point** — it's not a bug, it's the feature distinguishing it from [[BPDU Filter]].
- [[Port Security]] in `protect` or `restrict` mode does **not** err-disable; only `shutdown` mode (the default) does.
- A port in err-disabled is still configured — the running-config still shows it. It's just refusing to forward.

## Related concepts

[[BPDU Guard]] · [[Port Security]] · [[UDLD]] · [[PortFast]] · [[Spanning Tree Protocol]] · [[Root Guard]] · [[Loop Guard]] · [[Interface States]]

---
*Source: VIRGIL knowledge base*