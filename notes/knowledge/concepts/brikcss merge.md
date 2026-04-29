# brikcss merge

## What it is
Like a postal worker who blindly forwards packages without checking if the return address has been spoofed, brikcss merge is a JavaScript utility that deep-merges configuration objects without sanitizing inherited prototype properties. Precisely, it is an npm package that suffered a **prototype pollution vulnerability**, allowing an attacker to inject malicious properties into `Object.prototype` by supplying crafted input like `{"__proto__": {"isAdmin": true}}`.

## Why it matters
In a Node.js application using brikcss merge to combine user-supplied configuration with application defaults, an attacker could send a JSON payload containing `__proto__` keys, poisoning the global object prototype. Every subsequently created object in the runtime would inherit the injected property, potentially bypassing authorization checks (e.g., `if (user.isAdmin)` returning `true` for all users) without the attacker ever authenticating.

## Key facts
- **CVE-2019-10795** documents the prototype pollution flaw in brikcss merge versions prior to the patched release
- Prototype pollution attacks target JavaScript's prototype chain — properties set on `Object.prototype` are inherited by **all** objects in the same runtime
- The attack vector is **network-accessible** when user-controlled JSON is passed directly into a merge function, earning it a high CVSS score
- Mitigations include using `Object.create(null)` (no prototype), validating/sanitizing keys like `__proto__`, `constructor`, and `prototype` before merging, or using safe alternatives like `lodash >=4.17.13`
- This class of vulnerability is catalogued under **CWE-1321: Improperly Controlled Modification of Object Prototype Attributes**

## Related concepts
[[Prototype Pollution]] [[Supply Chain Attack]] [[Insecure Deserialization]] [[Input Validation]] [[CWE-1321]]