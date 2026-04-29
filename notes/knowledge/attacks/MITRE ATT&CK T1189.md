# MITRE ATT&CK T1189

## What it is
Like a poisoned watering hole in the savanna where lions wait for prey to drink, a Drive-by Compromise occurs when attackers inject malicious code into legitimate websites frequented by their targets. When a victim simply browses the compromised site, their browser automatically executes exploit code — no click, no download required.

## Why it matters
In the 2017 WannaCry campaign precursor activity, nation-state actors compromised industry-specific websites to deliver watering hole payloads targeting energy sector employees. A defender monitoring browser telemetry and unexpected child processes spawned from `chrome.exe` or `firefox.exe` would catch the lateral execution attempt before initial foothold was established.

## Key facts
- **No user interaction beyond browsing is required** — exploits target browser vulnerabilities, plugins (Flash, Java), or JavaScript engines to execute silently
- Attackers frequently use **exploit kits** (e.g., RIG, Angler) hosted on compromised or adversary-controlled infrastructure to automate payload delivery based on victim fingerprinting
- **Strategic Web Compromise (SWC)** is the targeted variant — attackers profile victims first, then compromise only the sites those specific targets visit
- Detection signatures include unexpected **PowerShell or cmd.exe processes spawned as children of browser processes**, which is abnormal parent-child process behavior
- Defenses include **browser isolation technologies**, disabling legacy plugins, Content Security Policy (CSP) headers, and network-layer URL filtering with reputation feeds

## Related concepts
[[Exploit Kits]] [[Watering Hole Attack]] [[T1203 Exploitation for Client Execution]] [[Browser Sandbox Escape]] [[Process Injection]]