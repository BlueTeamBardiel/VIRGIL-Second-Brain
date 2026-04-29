# Script Kiddie

## What it is
Like a teenager who downloads a pre-built LEGO kit and claims to be an architect, a script kiddie uses pre-written exploit tools and attack frameworks without understanding the underlying mechanics. Precisely defined: a low-skill threat actor who executes existing malware, scripts, or automated tools created by others, lacking the knowledge to develop novel attacks independently. They are opportunistic rather than targeted — exploiting volume over precision.

## Why it matters
In 2020, a wave of script kiddie attacks leveraged publicly released exploit code for the Zerologon vulnerability (CVE-2020-1472) within days of its disclosure. Organizations that delayed patching were compromised not by sophisticated APTs, but by unskilled attackers running downloaded proof-of-concept scripts. This illustrates why patch cadence and vulnerability management matter even against unsophisticated adversaries — the barrier to exploitation drops dramatically once working code goes public.

## Key facts
- Script kiddies represent the **highest volume** of attack attempts on internet-facing systems, even if they cause less sophisticated damage than APT actors
- They commonly use tools like **Metasploit, LOIC (Low Orbit Ion Cannon), SQLmap, and Kali Linux** without deep understanding of what those tools do internally
- Motivation is typically **notoriety, curiosity, or disruption** — not financial gain or espionage (distinguishes them from organized crime or nation-state actors)
- They are classified under the **unskilled attacker** threat actor category on the Security+ exam, contrasted with hacktivists, APTs, and insider threats
- Their attacks are often **noisy and easily detected** by basic IDS/IPS rules because they don't modify default tool signatures or evade logging mechanisms

## Related concepts
[[Threat Actor Types]] [[Metasploit Framework]] [[Vulnerability Exploitation]] [[Patch Management]] [[Intrusion Detection System]]