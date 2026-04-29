# Express

## What it is
Think of Express like a bare-bones postal sorting room — it moves packages (HTTP requests) through a series of handlers without providing any locks on the doors by default. Express is a minimal, unopinionated Node.js web application framework that handles HTTP routing and middleware chaining, deliberately shipping with almost no built-in security controls.

## Why it matters
A developer standing up an Express API without adding helmet.js or rate-limiting middleware is handing attackers an unlocked surface: default headers like `X-Powered-By: Express` fingerprint the stack, and without input validation middleware, endpoints are wide open to injection attacks. In a 2021-era API breach pattern, attackers enumerated Express routes via predictable REST conventions and exploited missing authentication middleware to access admin endpoints directly.

## Key facts
- Express ships with **no security headers by default** — `helmet.js` must be added explicitly to set CSP, HSTS, and remove the `X-Powered-By` header
- **Middleware order matters**: placing authentication middleware *after* a route declaration means that route is unprotected — a common misconfiguration
- Express does **not** sanitize request bodies by default; `express-validator` or similar must be added to prevent SQLi and XSS via `req.body`
- The `express-rate-limit` package is the standard defense against brute-force and credential-stuffing attacks on Express APIs
- Express's **trust proxy** setting, if misconfigured, allows attackers to spoof `X-Forwarded-For` headers, bypassing IP-based access controls

## Related concepts
[[Node.js Security]] [[HTTP Security Headers]] [[API Security]] [[Injection Attacks]] [[Middleware]]