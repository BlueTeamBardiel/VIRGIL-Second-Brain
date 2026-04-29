# AJAX

## What it is
Think of AJAX like a waiter who fetches specific menu items without closing the restaurant — the browser silently requests data from the server without reloading the entire page. AJAX (Asynchronous JavaScript and XML) is a technique that uses JavaScript to send HTTP requests in the background, allowing web applications to update content dynamically without full page refreshes. Modern implementations typically use JSON instead of XML.

## Why it matters
AJAX's asynchronous nature creates a blind spot for traditional security controls. An attacker can craft malicious requests to a vulnerable AJAX endpoint, and because these requests happen in the background without page navigation, they bypass CSRF token validation or same-origin policy checks if the application isn't careful. For example, a banking app using unprotected AJAX calls could allow an attacker to initiate transfers via JavaScript injected into a webpage.

## Key facts
- AJAX requests are XMLHttpRequest or Fetch API calls — they're still HTTP requests subject to the same-origin policy
- Vulnerable AJAX endpoints are prime targets for CSRF attacks if they lack proper token validation
- AJAX responses are parsed by JavaScript, making them vulnerable to DOM-based XSS if not sanitized properly
- Browser DevTools expose all AJAX traffic, so sensitive data should never be transmitted unencrypted
- CORS misconfiguration on AJAX endpoints allows cross-origin requests, potentially exposing sensitive APIs

## Related concepts
[[CSRF]] [[XSS]] [[CORS]] [[API Security]] [[Same-Origin Policy]]