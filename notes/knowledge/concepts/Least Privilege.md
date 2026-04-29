# least privilege

## What it is
Like a hospital where janitors have keys to supply closets but not the pharmacy — every user, process, and system should have *exactly* the access needed to do their job, and nothing more. Formally, the principle of least privilege (PoLP) states that subjects should operate with the minimum permissions required to perform authorized functions. It limits the blast radius when credentials are compromised or a process is exploited.

## Why it matters
In the 2020 SolarWinds attack, the malicious Orion software update ran with broad network permissions across thousands of enterprise environments — because admins had granted it sweeping access "just in case." If least privilege had been enforced, the lateral movement and data exfiltration across agencies and Fortune 500 companies would have been dramatically contained. Proper scoping of service account permissions is one of the most consistently neglected defenses in real environments.

## Key facts
- **Separation of duties** and least privilege are complementary — PoLP limits *what* you can access; separation of duties limits *what one person can do alone*
- Service accounts and application accounts are the most common PoLP violations — they accumulate permissions over time through a phenomenon called **privilege creep**
- Privileged Access Management (PAM) tools enforce PoLP for admin accounts by providing just-in-time (JIT) access rather than persistent elevated rights
- On Security+/CySA+: PoLP is a *preventive* control and is considered a core pillar of **Zero Trust Architecture**
- Linux implementation example: running a web server process as `www-data` (limited user) instead of `root` — a successful exploit then can't write to `/etc/passwd`

## Related concepts
[[privilege creep]] [[separation of duties]] [[zero trust]] [[privileged access management]] [[need to know]]