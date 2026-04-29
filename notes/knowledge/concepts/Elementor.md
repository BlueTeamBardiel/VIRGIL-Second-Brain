# Elementor

## What it is
Like a drag-and-drop LEGO set for websites, Elementor is a visual page builder plugin for WordPress that lets non-developers construct web pages through a graphical interface instead of writing code. It is one of the most widely installed WordPress plugins, running on millions of sites globally and handling frontend rendering, form submission, and widget functionality.

## Why it matters
In 2021, a critical vulnerability (CVE-2021-29447) in Elementor Pro allowed authenticated users with subscriber-level access to upload arbitrary files, enabling remote code execution — attackers exploited this to plant web shells and fully compromise hosting environments. This illustrates how widely-deployed plugins dramatically expand the attack surface of web applications, making plugin inventory and patch management essential defensive controls.

## Key facts
- Elementor Pro has repeatedly appeared in CVE databases with vulnerabilities including **privilege escalation**, **stored XSS**, and **arbitrary file upload** flaws
- Because Elementor runs on millions of sites, a single unpatched vulnerability becomes a **high-value mass exploitation target** for automated scanning tools
- Elementor forms can be vectors for **server-side request forgery (SSRF)** and **input validation bypass** if improperly configured
- WordPress plugin vulnerabilities account for over **90% of WordPress-related compromises**, making Elementor a representative case study for plugin risk
- Defenders should apply the principle of **least privilege** to WordPress user roles to limit blast radius when Elementor-class vulnerabilities are exploited

## Related concepts
[[WordPress Security]] [[Remote Code Execution]] [[Stored XSS]] [[Privilege Escalation]] [[Patch Management]]