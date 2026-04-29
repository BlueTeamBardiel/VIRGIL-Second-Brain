# Python pickle

## What it is
Think of pickle like a spell that freezes a live scorpion into ice — it looks safe until you thaw it out and it stings you. Pickle is Python's built-in serialization module that converts Python objects into a byte stream (pickling) and reconstructs them back into objects (unpickling). The danger is that unpickling executes arbitrary code embedded in the data during reconstruction.

## Why it matters
Attackers who can supply a malicious pickle payload to an application — via an API endpoint, a machine learning model file, or a Redis cache — can achieve remote code execution (RCE) with a single deserialized object. In 2019–2021, numerous ML pipelines loading untrusted `.pkl` model files became attack vectors because data scientists treated pickle files like inert data rather than executable code.

## Key facts
- Unpickling untrusted data is **always** an RCE risk — the `__reduce__` magic method is called during deserialization and can execute any OS command
- A minimal malicious payload: `os.system("whoami")` wrapped in a custom `__reduce__` can be crafted in under 5 lines of Python
- Pickle vulnerabilities fall under **CWE-502: Deserialization of Untrusted Data**, the same class as Java's notorious deserialization bugs
- Safe alternatives include `json`, `msgpack`, or `protobuf` — formats that cannot natively execute code during parsing
- The `pickletools` module can be used defensively to **audit** pickle bytecode before execution, though sandboxing is still preferable

## Related concepts
[[Insecure Deserialization]] [[Remote Code Execution]] [[CWE-502]] [[Supply Chain Attack]] [[OWASP Top 10]]