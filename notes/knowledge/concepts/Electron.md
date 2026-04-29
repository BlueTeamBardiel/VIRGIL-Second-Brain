# Electron

## What it is
Think of Electron like a shipping container that bundles a full web browser (Chromium + Node.js) inside a desktop app — convenient, but whatever vulnerabilities exist in the web stack come along for the ride. Electron is an open-source framework that allows developers to build cross-platform desktop applications using HTML, CSS, and JavaScript, essentially wrapping web technologies in a native application shell.

## Why it matters
In 2018, researchers discovered that older Electron-based apps (including Slack and Signal) were vulnerable to remote code execution via protocol handler abuse — an attacker could craft a malicious link that, when clicked, executed arbitrary JavaScript with Node.js privileges on the victim's machine. Because Electron apps often run with `nodeIntegration` enabled (giving JavaScript direct access to the OS), a single XSS vulnerability can escalate from "webpage annoyance" to full system compromise. This makes auditing Electron apps a high-priority task in enterprise environments where tools like VS Code, Discord, and Teams are ubiquitous.

## Key facts
- **Node.js integration risk**: When `nodeIntegration: true` is set in the main process, renderer-side JavaScript can call `require('child_process')` and execute OS commands — a critical misconfiguration.
- **Context isolation**: The recommended defense is enabling `contextIsolation: true` and using a `preload.js` script as a controlled bridge, preventing direct Node.js access from renderer code.
- **Protocol handler hijacking**: Electron apps registering custom URI schemes (e.g., `slack://`) can be exploited via crafted links to trigger unintended code execution.
- **Auto-update attack surface**: Electron apps that use unencrypted or unsigned update channels are susceptible to man-in-the-middle attacks delivering malicious updates.
- **Sandbox enforcement**: Modern Electron security best practice mandates enabling Chromium's sandbox (`sandbox: true`), reducing the blast radius of renderer compromise.

## Related concepts
[[Cross-Site Scripting (XSS)]] [[Remote Code Execution]] [[Privilege Escalation]] [[Supply Chain Attack]] [[Sandbox Escape]]