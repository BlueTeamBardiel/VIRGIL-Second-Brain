# Ruby

## What it is
Like a Swiss Army knife that comes pre-loaded with lock-picking tools, Ruby is a dynamic, interpreted programming language beloved by security professionals for its elegant syntax and powerful scripting capabilities. Precisely, it is a high-level, object-oriented language where everything is an object, designed around developer productivity and expressiveness. It is the language underlying the Metasploit Framework, making it foundational to modern penetration testing.

## Why it matters
When a red team operator needs to write a custom exploit module for Metasploit, they write it in Ruby — for example, crafting a payload that exploits a buffer overflow in an unpatched SMB service. Defenders analyzing suspicious scripts on a compromised Linux server may encounter Ruby-based reverse shells or post-exploitation tools that blend into development environments. Understanding Ruby syntax helps analysts recognize malicious code patterns in threat hunting and incident response.

## Key facts
- **Metasploit Framework** is written almost entirely in Ruby; writing custom modules requires Ruby knowledge (Security+ exam context: exploitation frameworks)
- Ruby uses **`.rb`** file extension; scripts are interpreted at runtime with no compilation step, making them easy to modify and deploy during engagements
- Ruby's **`open-uri`** and **`net/http`** libraries are commonly abused in malicious scripts to establish C2 (command-and-control) connections
- **Ruby gems** (packages) can introduce supply chain vulnerabilities — malicious gems have been discovered injecting credential-stealing code
- Ruby's **`eval()`** function is a high-risk method; unsanitized input passed to `eval()` enables code injection attacks similar to Python's equivalent

## Related concepts
[[Metasploit Framework]] [[Scripting Languages]] [[Supply Chain Attack]] [[Code Injection]] [[Penetration Testing]]