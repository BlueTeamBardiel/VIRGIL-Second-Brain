# postMessage

## What it is
Like a pneumatic tube in an old department store — you can send a sealed message between floors (origins) without physically crossing between them. `postMessage` is a browser API that enables cross-origin communication between window objects (iframes, popups, tabs) by passing serialized data across the Same-Origin Policy boundary in a controlled way.

## Why it matters
Attackers exploit misconfigured `postMessage` handlers where the receiving page fails to validate the `event.origin` property — allowing any malicious site to inject commands or steal data from a privileged frame. This technique was central to vulnerabilities found in OAuth flows and third-party payment widgets, where an attacker could silently exfiltrate tokens by spoofing postMessage events from a lookalike origin.

## Key facts
- **Origin validation is optional by default** — developers must explicitly check `event.origin` in the `message` event listener or any site can send data to the handler
- **Wildcard target origin (`"*`)** in `postMessage(data, "*")` means the message is sent regardless of the recipient's origin — a common misconfiguration that leaks data to attacker-controlled frames
- **Data is serialized via the Structured Clone Algorithm** — not HTML, so it doesn't trigger XSS directly, but the *handler* may unsafely inject received data into the DOM
- **Attack chain**: malicious iframe → `postMessage` to victim frame with crafted payload → victim handler executes it → DOM-based XSS or CSRF
- **Defense**: always validate `event.origin` against an allowlist AND treat `event.data` as untrusted input, sanitizing before DOM insertion

## Related concepts
[[Cross-Origin Resource Sharing (CORS)]] [[Same-Origin Policy]] [[DOM-based XSS]] [[iframe sandboxing]] [[clickjacking]]