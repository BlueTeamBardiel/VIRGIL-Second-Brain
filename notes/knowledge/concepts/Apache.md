# Apache

## What it is
Like a multilingual hotel concierge who receives guests (HTTP requests), routes them to the right room (web resource), and sends back exactly what they ordered — Apache HTTP Server is an open-source, cross-platform web server that processes client requests and serves web content using a modular architecture.

## Why it matters
In 2021, the Apache Log4j vulnerability (Log4Shell, CVE-2021-44228) demonstrated how a widely-deployed Apache component could expose millions of servers to remote code execution via a single malformed log string. Defenders had to rapidly identify every system running Log4j across their environment — a painful lesson in attack surface awareness and asset inventory.

## Key facts
- Apache HTTP Server runs on port **80** (HTTP) and **443** (HTTPS) by default; misconfigurations like directory listing enabled or verbose server banners leak version info to attackers
- The **`.htaccess`** file provides directory-level configuration — a common misconfiguration target that can bypass authentication controls if writable
- Apache uses a **module system** (e.g., `mod_ssl`, `mod_rewrite`); unnecessary modules increase attack surface and should be disabled (principle of least functionality)
- **CVE-2021-41773** (Apache 2.4.49) allowed path traversal and remote code execution via URL normalization flaws — patched in 2.4.51 within days of disclosure
- Apache is distinct from **Apache Tomcat**, which serves Java-based applications (JSP/Servlets) and has its own separate CVE history; conflating the two is a common exam trap

## Related concepts
[[Web Server Security]] [[Directory Traversal]] [[Log4Shell]] [[CVE Management]] [[HTTP Headers]]