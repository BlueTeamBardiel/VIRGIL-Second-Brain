# ASP.NET ViewState

## What it is
Like a waiter scribbling your order on a napkin and tucking it under your plate between courses — ViewState is a hidden HTML field (`__VIEWSTATE`) that ASP.NET uses to persist page state across HTTP requests, since HTTP itself is stateless. It stores serialized .NET objects as a Base64-encoded string embedded directly in the page's HTML.

## Why it matters
If a developer forgets to enable `EnableViewStateMac` (or uses a weak or hardcoded `machineKey`), an attacker can forge a malicious ViewState payload containing a serialized object that executes arbitrary code when the server deserializes it. This exact scenario played out in numerous real-world breaches — an attacker who finds a leaked `machineKey` in a public GitHub repo can craft a ViewState that achieves Remote Code Execution on the target ASP.NET application with no authentication required.

## Key facts
- ViewState is transmitted as the hidden form field `__VIEWSTATE` and is Base64-encoded, **not encrypted by default** — anyone can decode it
- The `machineKey` in `web.config` is used to sign (MAC) and optionally encrypt ViewState; a leaked or weak `machineKey` is a critical vulnerability
- Deserialization of a tampered ViewState triggers **insecure deserialization**, an OWASP Top 10 category (A08:2021)
- Tools like **ysoserial.net** can generate weaponized ViewState payloads for known .NET gadget chains
- Mitigation requires: `EnableViewStateMac=true`, strong randomly generated `machineKey`, and ideally `ViewStateEncryptionMode=Always` in `web.config`

## Related concepts
[[Insecure Deserialization]] [[CSRF]] [[Web.config Security]] [[Remote Code Execution]] [[OWASP Top 10]]