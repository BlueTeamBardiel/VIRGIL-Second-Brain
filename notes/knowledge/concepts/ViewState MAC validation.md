# ViewState MAC validation

## What it is
Like a wax seal on a medieval letter — if someone tampers with the contents, the seal breaks and the recipient knows not to trust it. ViewState MAC (Message Authentication Code) validation is an ASP.NET mechanism that cryptographically signs the ViewState field (a hidden HTML form field storing page state) using a server-side secret key, ensuring the client cannot modify it without detection.

## Why it matters
When MAC validation is disabled (`enableViewStateMac="false"` or exploited via key exposure), attackers can craft malicious ViewState payloads that trigger deserialization of arbitrary .NET objects — a critical vector used in real-world RCE attacks against SharePoint and other ASP.NET applications. The 2020 SharePoint exploitation wave (CVE-2020-16952) leveraged known `machineKey` values to forge valid ViewState and achieve remote code execution without authentication.

## Key facts
- ViewState is Base64-encoded and stored in a hidden `__VIEWSTATE` form field; without MAC validation it is trivially tampered with
- The MAC is computed using the `machineKey` in `web.config`; if this key leaks (via path traversal, LFI, or default keys), an attacker can forge valid signed payloads
- Disabling MAC validation (`enableViewStateMac="false"`) was officially removed as a supported option in ASP.NET 4.5.2+ due to abuse
- Tools like **YSoSerial.NET** automate the generation of malicious ViewState payloads once a `machineKey` is known
- Defense requires: MAC validation enabled, unique randomized `machineKey` per deployment, and ViewState encryption (`ViewStateEncryptionMode="Always"`)

## Related concepts
[[Deserialization attacks]] [[CSRF token validation]] [[Web.config security]] [[machineKey exposure]] [[Hidden field tampering]]