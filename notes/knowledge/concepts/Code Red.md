# Code Red

## What it is
Like a fast-moving wildfire that jumps fences on its own, Code Red was a self-propagating worm — it needed no human to click anything. Specifically, it exploited a buffer overflow vulnerability (MS01-033) in Microsoft IIS web servers, autonomously scanning for new victims and spreading without any user interaction.

## Why it matters
In July 2001, Code Red infected over 359,000 machines in just 14 hours, demonstrating that automated network worms could cause internet-scale disruption faster than human defenders could respond. It was programmed to launch a distributed denial-of-service (DDoS) attack against the White House website on the 20th of each month, forcing administrators to change the site's IP address as a defensive countermeasure.

## Key facts
- Exploited **CVE-2001-0500**, a buffer overflow in the ISAPI extension of Microsoft IIS 4.0 and 5.0
- Operated entirely **in memory** — it wrote no files to disk, making traditional file-based antivirus detection ineffective
- Propagated by randomly generating IP addresses and attempting to infect port **80 (HTTP)**
- Caused an estimated **$2 billion in damages** from remediation and lost productivity
- Demonstrated the critical need for **patch management** — a patch had been available for 30 days before the outbreak began, yet millions of servers remained unpatched

## Related concepts
[[Buffer Overflow]] [[Worm]] [[Patch Management]] [[IIS Security]] [[DDoS]]