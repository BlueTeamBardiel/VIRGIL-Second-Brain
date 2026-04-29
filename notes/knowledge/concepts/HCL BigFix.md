# HCL BigFix

## What it is
Think of it as a remote control for an entire fleet of computers — like a ship captain who can simultaneously adjust the sails on every vessel in the armada with a single command. HCL BigFix is an endpoint management and security platform that enables centralized patch deployment, configuration enforcement, and compliance monitoring across tens of thousands of endpoints in near real-time. It operates via a lightweight agent installed on each managed device that receives and executes policy instructions from a central server.

## Why it matters
During the 2021 Log4Shell vulnerability crisis, organizations scrambled to identify and patch every vulnerable instance across their infrastructure within hours. BigFix customers could query their entire endpoint fleet for the presence of Log4j, identify affected systems, and deploy patches — all within a single console session — dramatically shrinking the window of exposure compared to manual or slower-polling alternatives.

## Key facts
- BigFix uses a **relay hierarchy** to scale efficiently: endpoints report to relays, relays report to the root server, reducing bandwidth strain on large networks
- The core policy language is called **Relevance** — a proprietary query language used to determine *if* a fix applies before executing it, preventing unnecessary changes
- BigFix can enforce **continuous compliance** by automatically re-remediating drift (e.g., if a firewall rule is manually disabled, BigFix can restore it automatically)
- It supports **heterogeneous environments**: Windows, Linux, macOS, AIX, Solaris — critical for enterprises with mixed infrastructure
- BigFix is classified as both an **EPP (Endpoint Protection Platform)** tool and an **ITOM (IT Operations Management)** tool, bridging security and operations teams

## Related concepts
[[Patch Management]] [[Endpoint Detection and Response]] [[Configuration Management]] [[Vulnerability Scanning]] [[Security Content Automation Protocol (SCAP)]]