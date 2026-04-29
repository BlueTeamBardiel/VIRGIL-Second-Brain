# WSD

## What it is
Like a postal worker who delivers packages to the wrong address because two residents share the same name, WSD (Web Skimming Detection) — more precisely, **Web Skimming/Digital Skimming Defense** — refers to techniques that identify malicious JavaScript injected into e-commerce pages to silently steal payment card data during checkout. It is a defensive discipline focused on detecting and mitigating Magecart-style supply chain attacks where adversaries compromise third-party scripts or directly inject malicious code into payment forms.

## Why it matters
In the British Airways breach (2018), attackers injected 22 lines of JavaScript into the payment page, exfiltrating card data for approximately 500,000 customers over two weeks before detection. WSD tools using Subresource Integrity (SRI) checks and Content Security Policy (CSP) monitoring would have flagged the unauthorized script modification or outbound data exfiltration to an attacker-controlled domain.

## Key facts
- **Magecart** is the primary threat actor category associated with web skimming; over a dozen distinct Magecart subgroups have been identified
- **Subresource Integrity (SRI)** is a browser-side defense: hash values in `<script>` tags ensure loaded scripts haven't been tampered with
- **Content Security Policy (CSP)** headers can block unauthorized external domains from receiving exfiltrated form data via `form-action` directives
- Web skimmers frequently target **third-party JavaScript** (analytics, chat widgets, ad libraries) — the actual merchant site may remain uncompromised
- Detection methods include **behavioral analysis** (watching for form field data being copied and sent to external endpoints), script change monitoring, and real-time DOM inspection

## Related concepts
[[Content Security Policy]] [[Subresource Integrity]] [[Magecart]] [[Supply Chain Attack]] [[Cross-Site Scripting]]