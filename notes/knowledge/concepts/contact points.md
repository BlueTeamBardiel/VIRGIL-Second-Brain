# contact points

## What it is
Like every door, window, and mail slot in a building that an intruder could use to enter, contact points are all the places where an attacker can interact with a system or organization. Precisely defined, contact points (often called *attack surface entry points*) are the specific interfaces, services, APIs, user inputs, and physical access locations through which external or internal actors can send data to — or trigger behavior in — a target system.

## Why it matters
During the 2017 Equifax breach, attackers exploited a single exposed web application endpoint running a vulnerable version of Apache Struts — one overlooked contact point in a massive surface. Had Equifax inventoried and patched all externally reachable interfaces, that specific entry would have been hardened or removed, denying the attacker their foothold entirely.

## Key facts
- Contact points include network ports, web APIs, login forms, email inputs, USB ports, Bluetooth interfaces, and even help-desk phone lines (social engineering vectors)
- Reducing the number of active contact points is called **attack surface reduction** — a core principle of least functionality
- Each contact point requires its own **input validation** and **authentication control**; an unprotected point undermines all others
- Contact points are enumerated during the **reconnaissance** phase of penetration testing using tools like Nmap, Shodan, and Burp Suite
- Security+ and CySA+ exam scenarios often test whether candidates can identify *unnecessary* contact points that should be disabled (e.g., open Telnet port on a managed switch)

## Related concepts
[[attack surface]] [[attack vectors]] [[least functionality]] [[reconnaissance]] [[input validation]]