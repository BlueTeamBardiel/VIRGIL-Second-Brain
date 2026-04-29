# Chromium

## What it is
Think of Chromium as the raw engine block that car manufacturers buy before bolting on their own dashboards and badges — it's the open-source browser project that Google, Microsoft (Edge), Brave, and dozens of others build their finished products on top of. Precisely: Chromium is an open-source browser codebase maintained primarily by Google that provides the rendering engine (Blink) and JavaScript engine (V8) used by most major modern browsers.

## Why it matters
When a critical vulnerability is discovered in Chromium's V8 engine — such as the zero-day CVE-2021-21224 exploited in the wild — it doesn't affect just Chrome users; it simultaneously threatens every browser built on that shared codebase. Attackers who find a single Chromium exploit can effectively target the vast majority of the browser market, making Chromium vulnerabilities extremely high-value targets for exploit kit authors and nation-state actors.

## Key facts
- Chromium powers browsers representing **over 65% of global browser market share**, meaning a single engine flaw has massive blast radius
- The **Site Isolation** security feature — introduced after Spectre — runs each website in a separate process to prevent cross-site data leakage
- Chromium's **sandbox architecture** restricts renderer processes from directly accessing the OS, requiring privilege escalation exploits to break out fully
- Google's **Vulnerability Reward Program (VRP)** pays up to $150,000 for Chromium sandbox escapes, reflecting their severity
- **CVE tracking for Chromium** is critical for patch management; organizations running custom Chromium-based browsers (like Electron apps) often lag behind official patches, creating persistent exposure windows

## Related concepts
[[Browser Sandbox]] [[V8 JavaScript Engine]] [[Cross-Site Scripting (XSS)]] [[Zero-Day Vulnerability]] [[Electron Framework Security]]