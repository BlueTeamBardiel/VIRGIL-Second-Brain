# Target Specification

## What it is
Like a detective writing a warrant — you must precisely name *who* you're authorized to investigate before you knock on any doors. Target specification is the formal process of defining the exact scope of systems, IP addresses, hostnames, or networks that are authorized for scanning or penetration testing before any tools are executed.

## Why it matters
During a penetration test engagement, a tester who scans `192.168.1.0/24` when authorized only for `192.168.1.50` has just conducted unauthorized access — potentially violating the Computer Fraud and Abuse Act (CFAA). Proper target specification in tools like Nmap (e.g., using `-iL targets.txt` with a pre-approved host list) creates a documented, defensible boundary between legal testing and criminal activity.

## Key facts
- Nmap supports target specification via individual IPs, CIDR ranges (`10.0.0.0/24`), dash ranges (`10.0.0.1-50`), hostname resolution, and input files (`-iL`)
- The **Rules of Engagement (ROE)** document legally defines authorized targets before any test begins — deviating from it voids legal protection
- **Scope creep** — scanning systems outside the defined target list — is one of the most common causes of penetration test legal incidents
- CIDR notation mistakes (e.g., `/16` instead of `/24`) can expand a target list from 256 hosts to 65,536 hosts, a significant overshoot
- On Security+/CySA+ exams, target specification errors are categorized under **reconnaissance** phase failures and tied to concepts of **authorization** and **scope management**

## Related concepts
[[Rules of Engagement]] [[Network Scanning]] [[Reconnaissance]] [[Scope of Work]] [[Nmap]]