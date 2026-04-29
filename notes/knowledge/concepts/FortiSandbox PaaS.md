# FortiSandbox PaaS

## What it is
Like sending a suspicious package to a remote bomb squad instead of opening it in your own mailroom, FortiSandbox PaaS offloads unknown file detonation to Fortinet's cloud infrastructure. It is a Platform-as-a-Service implementation of dynamic malware analysis where submitted files and URLs are executed in isolated virtual environments hosted by Fortinet, observing behavior without risking the customer's on-premises systems.

## Why it matters
In a 2022-style spear-phishing campaign, an employee receives a weaponized Excel file with a macro dropper. Before delivery completes to the endpoint, the organization's FortiGate firewall submits the attachment to FortiSandbox PaaS, which detonates it in a cloud VM and observes it attempting to reach a C2 server — blocking delivery before any human ever opens it. This real-time verdict loop is the difference between prevention and incident response.

## Key facts
- FortiSandbox PaaS integrates natively with FortiGate, FortiMail, and FortiWeb via Security Fabric, enabling automated file submission and verdict-based blocking
- Uses multi-layer static analysis (AV signatures, AI/ML scoring) *before* dynamic detonation, reducing cloud processing load
- Verdicts are returned as Clean, Malicious, Suspicious, or Timeout — each triggering configurable policy responses
- Threat intelligence from detonations feeds back into FortiGuard Labs, contributing to the global threat database (crowdsourced defense model)
- Unlike on-premises FortiSandbox appliances, the PaaS model requires no hardware investment but introduces a dependency on internet connectivity and raises data-sovereignty considerations for regulated industries

## Related concepts
[[Dynamic Malware Analysis]] [[Security Fabric]] [[Zero-Day Threat Detection]] [[Cloud-Based Threat Intelligence]] [[Sandboxing]]