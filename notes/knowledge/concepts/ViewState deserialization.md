# ViewState deserialization

## What it is
Think of ViewState like a sealed lunch bag passed back and forth between a waiter and the kitchen — if someone tampers with what's inside before it returns, the kitchen blindly acts on poisoned instructions. Precisely: ViewState is an ASP.NET mechanism that serializes page state into a hidden HTML field (`__VIEWSTATE`) to persist data between HTTP requests. When the server deserializes that field without proper validation, attackers can inject malicious serialized objects to achieve Remote Code Execution (RCE).

## Why it matters
In 2019–2020, attackers exploited unprotected ViewState in IIS/ASP.NET servers by forging malicious payloads using known `MachineKey` values leaked from public repositories or default configurations — tools like **ysoserial.net** automated gadget chain generation. If a site lacks a `MachineKey` (or uses a known/weak one), an attacker sends a crafted `__VIEWSTATE` value and the server executes arbitrary commands upon deserialization, with no authentication required.

## Key facts
- ViewState is base64-encoded and stored in a hidden HTML form field; encoding ≠ encryption or integrity.
- **MachineKey** (`validationKey` + `decryptionKey` in `web.config`) is used to sign and optionally encrypt ViewState — its exposure is the root vulnerability.
- Without MAC validation (`EnableViewStateMac=false`), any attacker can forge payloads directly; this was the default-off behavior before ASP.NET 4.5.1.
- **ysoserial.net** is the primary tool used to craft .NET deserialization gadget chains targeting ViewState.
- Mitigation includes: rotating `MachineKey` values, never hardcoding them, enabling ViewState encryption, and using `__VIEWSTATEGENERATOR` validation.

## Related concepts
[[Insecure deserialization]] [[MachineKey exposure]] [[Remote Code Execution]] [[ysoserial gadget chains]] [[ASP.NET security misconfiguration]]