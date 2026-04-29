# Apache Tomcat

## What it is
Think of Apache Tomcat as a specialized kitchen that only knows how to cook Java dishes — it receives orders (HTTP requests), runs Java Servlet and JSP code, and plates the responses back to diners. Precisely, it is an open-source Java application server and servlet container that implements the Jakarta Servlet and JavaServer Pages specifications, sitting between a web server and Java-based backend applications.

## Why it matters
In 2020, **CVE-2020-1938 ("Ghostcat")** exposed a critical flaw in Tomcat's AJP connector — an internal protocol port (8009) left open by default allowed unauthenticated attackers to read any file from the webapp directory or achieve remote code execution by uploading malicious files. Organizations running Tomcat on internet-facing servers without disabling AJP were trivially compromised, making default-configuration hardening a critical defensive step.

## Key facts
- Default ports: **8080** (HTTP), **8443** (HTTPS), **8009** (AJP connector — frequently exploited and should be disabled if unused)
- Tomcat runs as its own process and should **never run as root** — least-privilege service accounts are mandatory
- Configuration files live in `conf/server.xml` (connector settings) and `conf/web.xml` (security constraints); misconfigurations here are a primary attack surface
- The **Manager Application** (default path `/manager/html`) provides remote WAR file deployment — leaving it exposed with default credentials (`tomcat:tomcat`) is a notorious entry point for attackers
- Tomcat is distinct from a full Java EE server (like JBoss/WildFly) — it implements only the servlet/JSP subset, making it lightweight but purpose-limited

## Related concepts
[[Web Application Firewall]] [[Default Credentials]] [[Remote Code Execution]] [[AJP Protocol]] [[Least Privilege]]