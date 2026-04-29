# machineKey

## What it is
Think of it as the master key hanging in the server room — anyone who copies it can forge any lock in the building. `machineKey` is an ASP.NET configuration element containing cryptographic keys used to sign and encrypt ViewState, authentication cookies, and session tokens, ensuring data hasn't been tampered with between client and server.

## Why it matters
In 2017, researchers demonstrated that leaked or default `machineKey` values in ASP.NET applications could be exploited to forge ViewState payloads that trigger remote code execution — no authentication required. If an attacker discovers a predictable or publicly documented `machineKey` (often left at defaults in shared hosting), they can craft malicious serialized objects that the server blindly deserializes and executes.

## Key facts
- `machineKey` contains two sub-keys: `validationKey` (for HMAC integrity checking) and `decryptionKey` (for AES/DES encryption of sensitive tokens)
- Default or auto-generated keys can be identical across servers unless explicitly set — a critical misconfiguration in web farms and shared hosting environments
- ViewState MAC validation relies entirely on the `machineKey`; disabling MAC validation (`enableViewStateMac=false`) removes the only protection against ViewState injection attacks
- Exposed `web.config` files (via directory traversal, source code leaks, or Git repositories) are the most common way attackers harvest `machineKey` values
- In .NET Framework, `machineKey` lives in `web.config` or `machine.config`; in ASP.NET Core, it has been replaced by the **Data Protection API** with automatic key rotation

## Related concepts
[[ViewState]] [[Insecure Deserialization]] [[Web.config Exposure]] [[Data Protection API]] [[HMAC]]