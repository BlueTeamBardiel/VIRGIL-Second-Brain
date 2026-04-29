# Client-side prototype pollution

## What it is
Imagine every JavaScript object in a browser is a house built from the same blueprint — if you scribble on the master blueprint, every house suddenly has an extra room nobody asked for. Client-side prototype pollution is a vulnerability where an attacker injects properties into JavaScript's `Object.prototype` via unsanitized user-controlled input (like URL parameters or JSON), causing those properties to appear on every object in the application and potentially hijacking execution flow.

## Why it matters
In 2019, researchers demonstrated that prototype pollution in widely-used libraries like jQuery could be chained with gadgets in the same codebase to escalate into DOM-based XSS — no server interaction required. An attacker crafts a URL like `?__proto__[isAdmin]=true`, and if the app blindly merges query parameters into objects, every subsequent permission check reading `obj.isAdmin` returns `true`.

## Key facts
- The attack vector is typically malicious keys like `__proto__`, `constructor`, or `prototype` embedded in JSON payloads or URL query strings
- Prototype pollution alone is often low-severity; danger escalates when combined with **gadgets** — existing code paths that read the polluted property and perform dangerous actions (eval, innerHTML assignment, etc.)
- Defense: use `Object.create(null)` to create objects with no prototype, or validate/sanitize keys before merging with `Object.assign()` or lodash merge functions
- `JSON.parse()` is **not** vulnerable by itself — pollution requires the app to recursively merge parsed data into existing objects
- Libraries historically vulnerable include lodash (CVE-2019-10744), jQuery (CVE-2019-11358), and minimist — patched versions are essential

## Related concepts
[[DOM-based XSS]] [[JavaScript Injection]] [[Insecure Deserialization]]