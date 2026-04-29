# DOM Invader

## What it is
Think of it as a metal detector built into your browser — instead of scanning for buried coins, it scans every JavaScript sink and source for dangerous data flows in real time. DOM Invader is a browser-based tool bundled with Burp Suite's Chromium browser that automatically detects DOM-based XSS vulnerabilities and prototype pollution by monitoring how user-controlled input travels through a page's Document Object Model.

## Why it matters
During a penetration test against a single-page application, an attacker might spend hours manually tracing whether a URL fragment (`location.hash`) ever reaches `innerHTML` or `eval()`. DOM Invader eliminates that grunt work by injecting a unique canary value and alerting the tester the moment that value lands in a dangerous sink — turning a multi-hour manual audit into a minutes-long automated scan that surfaces exploitable injection points.

## Key facts
- DOM Invader is built into the **Burp Suite browser** (Chromium-based) and activated via a browser extension toggle — it does not intercept network traffic, only monitors client-side JavaScript behavior.
- It tracks **sources** (e.g., `location.search`, `document.referrer`, `postMessage`) flowing into **sinks** (e.g., `innerHTML`, `document.write`, `eval`) — the exact model used to classify DOM XSS.
- The tool includes a **postMessage listener** that can detect when cross-origin messages deliver tainted data into dangerous sinks — a frequently overlooked DOM XSS vector.
- DOM Invader can detect **prototype pollution** by checking whether injected properties corrupt `Object.prototype` and subsequently reach a gadget that causes harm.
- Results appear in a dedicated **DOM Invader tab** inside browser DevTools, showing the full source-to-sink call stack for each finding.

## Related concepts
[[DOM-based XSS]] [[Prototype Pollution]] [[Burp Suite]] [[Cross-Site Scripting (XSS)]] [[postMessage Security]]