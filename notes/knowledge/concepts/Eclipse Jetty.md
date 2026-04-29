# Eclipse Jetty

## What it is
Think of it as a Swiss Army knife embedded directly in your application's backpack — you don't need a separate server building to run your code. Eclipse Jetty is a lightweight, open-source Java-based HTTP server and servlet container that can be embedded directly within Java applications, eliminating the need for a standalone application server like Tomcat or JBoss.

## Why it matters
In 2021, researchers disclosed **CVE-2021-28164** and **CVE-2021-34428**, critical Jetty vulnerabilities allowing path traversal and session fixation attacks against widely-deployed applications. Because Jetty is frequently embedded invisibly inside enterprise tools (like Jenkins CI/CD pipelines), administrators often fail to patch it — making it a quiet, persistent attack vector where the *real* server is hiding inside an application they think is just a tool.

## Key facts
- **Embedded deployment model**: Jetty runs inside the JVM process of the host application, so version tracking and patch management are the *application developer's* responsibility, not the sysadmin's — a common patch-gap source.
- **Path traversal vulnerabilities**: CVE-2021-28164 allowed attackers to access protected resources via encoded URI sequences (`%2e%2e/`), bypassing security constraints — a textbook input validation failure.
- **Session fixation risk**: CVE-2021-34428 permitted session cookie persistence after logout when using certain authentication modules, enabling session hijacking.
- **Default ports**: Jetty typically runs on port **8080** (HTTP) and **8443** (HTTPS); identifying these during reconnaissance can reveal embedded Jetty instances.
- **Widespread hidden exposure**: Jetty underpins tools like Jenkins, JIRA, and various IoT device management consoles — attackers enumerate these specifically because organizations rarely treat them as "servers."

## Related concepts
[[Path Traversal Attack]] [[Session Fixation]] [[CVE Management]] [[Java Servlet Container]] [[Supply Chain Vulnerability]]