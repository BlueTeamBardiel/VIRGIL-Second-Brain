# Wildcard Mask

## What it is

In Tekken, a move input like `f,F+2` means "tap forward, then hold forward and press 2" — but the game doesn't care what your left hand is doing, whether you're mashing block, or how loud you're yelling. Only the specific buttons in the notation matter; everything else is ignored. That's exactly what a **wildcard mask** does — it tells the router which bits of an [[IP Address]] must match exactly and which bits are free to be anything.

A wildcard mask is a 32-bit value where **0 means "this bit must match"** and **1 means "this bit is a wildcard — don't care."**

## Why it matters

Get the wildcard mask wrong in an [[ACL]] and you either block traffic you meant to allow (users start filing tickets) or permit traffic you meant to deny (security audit fails). Get it wrong in an [[OSPF]] `network` statement and the wrong interfaces join the wrong areas — or none at all — and routing silently breaks. On the CCNA, expect at least one question that hands you a subnet and asks for the wildcard mask, and another that hides a wildcard mask error inside a config snippet.

## Key facts

### The 0/1 logic (inverse of subnet mask)

Where a [[Subnet Mask]] uses 1s to mark the network portion, a wildcard mask uses 0s for the bits that must match.

| Purpose | Subnet Mask | Wildcard Mask |
|---|---|---|
| 1 bit | network/host boundary | ignore this bit |
| 0 bit | host portion | must match exactly |

### Calculation

Subtract the subnet mask from `255.255.255.255`:

| Subnet Mask | Wildcard Mask | Hosts matched |
|---|---|---|
| 255.255.255.255 (/32) | 0.0.0.0 | 1 (single host) |
| 255.255.255.252 (/30) | 0.0.0.3 | 4 |
| 255.255.255.240 (/28) | 0.0.0.15 | 16 |
| 255.255.255.0 (/24) | 0.0.0.255 | 256 |
| 255.255.0.0 (/16) | 0.0.255.255 | 65,536 |
| 0.0.0.0 (/0) | 255.255.255.255 | everything |

Shortcut: per octet, `255 - subnet_octet = wildcard_octet`.

### Special keywords

- **`host x.x.x.x`** is shorthand for `x.x.x.x 0.0.0.0` — match exactly one address.
- **`any`** is shorthand for `0.0.0.0 255.255.255.255` — match anything.

### Use in ACLs

```
! Permit a single host
access-list 10 permit host 192.168.1.50

! Permit the 192.168.1.0/24 subnet
access-list 10 permit 192.168.1.0 0.0.0.255

! Permit anything
access-list 10 permit any

! Extended ACL: permit 10.0.0.0/8 to web server 172.16.5.10
access-list 100 permit tcp 10.0.0.0 0.255.255.255 host 172.16.5.10 eq 80
```

The router checks the source/destination against the wildcard mask. Bits with `0` in the mask must match; bits with `1` are ignored.

### Use in OSPF network statements

```
router ospf 1
 network 192.168.1.0 0.0.0.255 area 0
 network 10.10.10.1 0.0.0.0 area 0
```

The wildcard tells [[OSPF]] which interface IPs to match. The second line above matches *only* the interface with IP `10.10.10.1` — a precise way to enable OSPF on one interface without dragging in neighbors.

### Non-contiguous wildcards (the cursed feature)

Unlike subnet masks, wildcard masks don't have to be contiguous. `0.0.0.254` matches all even addresses in the last octet. Useful, occasionally. Confusing, always. Not a CCNA focus, but know it's legal.

### Common confusion

- Students write `192.168.1.0 255.255.255.0` in an ACL. Router accepts it but matches the wrong addresses — `255` in a wildcard means "ignore this octet."
- Forgetting that `host 1.1.1.1` and `1.1.1.1 0.0.0.0` are identical.
- OSPF `network 0.0.0.0 255.255.255.255 area 0` enables OSPF on every interface. Lazy, but it works.

## Related concepts

[[Subnet Mask]] · [[ACL]] · [[Extended ACL]] · [[OSPF]] · [[CIDR Notation]] · [[IP Address]] · [[Access-List Configuration]]

---
*Source: VIRGIL knowledge base*