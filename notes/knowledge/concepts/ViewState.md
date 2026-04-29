# ViewState

## What it is
Think of ViewState like a sticky note taped to the back of a web form — it secretly holds the page's memory between clicks so the server doesn't forget what you were doing. Precisely, ViewState is an ASP.NET mechanism that serializes and stores client-side state data in a hidden HTML form field (`__VIEWSTATE`), transmitted back to the server on each postback. The data is Base64-encoded by default, but not encrypted or signed unless explicitly configured.

## Why it matters
In 2019, attackers exploited unsecured ViewState in ASP.NET applications to achieve Remote Code Execution (RCE). Because ViewState uses .NET's `BinaryFormatter` for deserialization, an attacker who knows (or steals) the `MachineKey` can forge a malicious ViewState payload that executes arbitrary code when the server deserializes it — no authentication required. This made leaked `MachineKey` values from configuration files a critical attack primitive.

## Key facts
- ViewState is stored in a hidden HTML field named `__VIEWSTATE` and is Base64-encoded — **not encrypted by default**, meaning anyone can decode and read it
- Without `EnableViewStateMac=true` and a secret `MachineKey`, the server cannot verify tampering, enabling **deserialization attacks**
- Attackers can use tools like **ysoserial.net** to generate weaponized ViewState payloads for RCE if the MachineKey is known
- ASP.NET 4.5.2+ enables MAC validation by default, but misconfigurations (explicit `EnableViewStateMac=false`) still appear in legacy apps
- Exposed `MachineKey` values in `web.config` files (often leaked via path traversal or source disclosure) are the **key prerequisite** for ViewState exploitation

## Related concepts
[[Deserialization Attacks]] [[Remote Code Execution]] [[Web Application Security]]