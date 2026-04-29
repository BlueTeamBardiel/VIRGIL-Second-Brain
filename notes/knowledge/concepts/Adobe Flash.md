# Adobe Flash

## What it is
Think of Flash like a master key that once opened every door in the internet's entertainment district — convenient for everyone, including the burglars. Adobe Flash was a browser plugin and runtime environment that enabled rich multimedia content (animations, video, games) inside web pages using the `.swf` file format, running client-side with elevated privileges.

## Why it matters
Flash became one of the most exploited attack surfaces in browser history. Attackers routinely embedded malicious SWF files in drive-by download campaigns — a user visits a compromised website, Flash automatically executes the payload, and the attacker gains code execution without any user interaction beyond clicking a link. CVE-2018-15982, a use-after-free vulnerability in Flash, was actively exploited in the wild before Adobe's end-of-life announcement.

## Key facts
- Adobe officially **end-of-lifed Flash on December 31, 2020**, after which Adobe actively blocks Flash content from running
- Flash vulnerabilities frequently fell into categories of **use-after-free, heap overflow, and type confusion** — all enabling remote code execution
- Flash was a primary vector for **drive-by downloads** and **malvertising** campaigns throughout the 2000s–2010s
- The **CVE-2015-3113** Flash zero-day was exploited by APT3 (a Chinese state-sponsored group) in targeted phishing campaigns
- Flash operated **outside browser sandboxes** in older configurations, giving exploits direct OS-level access

## Related concepts
[[Drive-By Download]] [[Browser Exploitation]] [[Zero-Day Vulnerability]] [[Malvertising]] [[End-of-Life Software]]