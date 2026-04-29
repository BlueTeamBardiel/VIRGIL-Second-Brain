# ysoserial

## What it is
Think of it like a vending machine exploit: you know the machine accepts sealed packages, so you craft a *specially malformed package* that, when the machine opens it, triggers an unexpected action — like dispensing everything for free. ysoserial is an open-source Java tool that generates malicious serialized payloads, exploiting the way Java applications deserialize untrusted data to achieve remote code execution (RCE). It packages known "gadget chains" — sequences of existing Java classes that, when chained together during deserialization, execute attacker-controlled commands.

## Why it matters
In 2015–2016, researchers used ysoserial-style attacks to compromise Apache Commons Collections in widely deployed enterprise applications, including Jenkins, WebLogic, and JBoss, leading to full server takeover. A penetration tester discovering a Java application that accepts serialized objects over a network can use ysoserial to test whether the endpoint is vulnerable by sending a payload such as `ysoserial CommonsCollections6 'whoami'` to confirm code execution without needing source code access.

## Key facts
- ysoserial ships with multiple **gadget chain modules** (e.g., CommonsCollections1–7, Spring, Hibernate) targeting different vulnerable library combinations
- Java deserialization vulnerabilities typically manifest at **`ObjectInputStream.readObject()`** — the target entry point for these payloads
- The magic bytes `AC ED 00 05` in network traffic or files indicate a **Java serialized object**, a key detection indicator
- Defenses include **SerialKiller** (a deserialization filter), Java's **`ObjectInputFilter`** (JEP 290), and avoiding deserialization of untrusted data entirely
- ysoserial payloads require the **target classpath to contain the vulnerable library** — the attack is dependency-specific, not universal

## Related concepts
[[Java Deserialization]] [[Remote Code Execution]] [[Gadget Chains]] [[ObjectInputStream]] [[OWASP A08 Software and Data Integrity Failures]]