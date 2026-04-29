# OWASP ZAP

## What it is
Think of it as a transparent glass pipe inserted between your browser and a web server — you can see, pause, and tamper with every message flowing through it. OWASP ZAP (Zed Attack Proxy) is a free, open-source web application security scanner that performs both active and passive vulnerability testing by acting as a man-in-the-middle proxy. It's maintained by OWASP and is the most widely used open-source DAST (Dynamic Application Security Testing) tool.

## Why it matters
During a penetration test against a healthcare portal, a tester uses ZAP's active scanner to automatically inject SQL payloads into login form fields — discovering that the patient records endpoint returns raw database errors, confirming SQL injection. Without a tool like ZAP, manually crafting and tracking hundreds of injection variations across dozens of endpoints would take days instead of hours.

## Key facts
- ZAP operates as an **intercepting proxy** on localhost (default port 8080), sitting between the browser and target application to capture and modify HTTP/HTTPS traffic in real time
- **Passive scanning** observes traffic without sending extra requests (safe for production); **active scanning** fires attack payloads and should only be used against systems you have explicit permission to test
- Includes a **Spider** (crawler) that automatically maps application endpoints and a **Fuzzer** for injecting wordlists into any request parameter
- ZAP can be run in **headless/daemon mode** via CLI and integrated into CI/CD pipelines for automated DevSecOps testing
- Relevant to **Security+ and CySA+** as an example of a vulnerability scanner, DAST tool, and proxy-based testing under the "Application Security" and "Threat and Vulnerability Management" domains

## Related concepts
[[Web Application Firewall]] [[Burp Suite]] [[SQL Injection]] [[Dynamic Application Security Testing]] [[Penetration Testing]]