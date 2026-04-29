# Heat Map

## What it is
Like a weather map that uses color gradients to show temperature hotspots across a region, a heat map in cybersecurity uses color intensity to visualize where threats, vulnerabilities, or risks are most concentrated across an environment. Precisely, it is a graphical representation of data where values are encoded as colors, allowing analysts to quickly identify high-risk areas, attack frequency patterns, or vulnerability density across systems, networks, or time periods.

## Why it matters
During a SOC investigation, an analyst might overlay a heat map of failed login attempts across a 24-hour period and immediately spot a tight cluster of activity between 2–4 AM from a single geographic region — a clear indicator of a brute-force campaign. Without the visual aggregation, the same pattern buried in raw log data could take hours to manually identify. Heat maps compress analytical time significantly in high-volume environments.

## Key facts
- **Risk heat maps** plot likelihood vs. impact on a matrix grid; cells colored red indicate risks requiring immediate mitigation — a core tool in risk management frameworks like NIST RMF
- Used in **vulnerability management** to show which systems or network segments carry the highest concentration of unpatched CVEs
- **Geographic heat maps** are common in threat intelligence platforms (e.g., ThreatConnect, Recorded Future) to visualize attack origin by country or region
- On the **CySA+ exam**, heat maps appear in the context of threat analysis dashboards and SIEM visualization tools used during continuous monitoring
- Heat maps support **trend analysis** — comparing maps across time periods reveals whether remediation efforts are actually reducing risk concentration

## Related concepts
[[Risk Matrix]] [[SIEM]] [[Vulnerability Scanning]] [[Threat Intelligence]] [[Continuous Monitoring]]