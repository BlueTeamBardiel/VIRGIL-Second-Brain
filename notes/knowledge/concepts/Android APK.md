# Android APK

## What it is
Think of an APK like a LEGO set in a single zip-locked bag — it contains every piece (code, resources, assets, manifest) needed to assemble and run an Android application. Precisely, an APK (Android Package Kit) is a compressed archive file (`.apk`) using ZIP format that bundles all components required for Android app installation and execution.

## Why it matters
Attackers routinely repackage legitimate APKs — unpacking a banking app with `apktool`, injecting malicious Smali bytecode, re-signing with a rogue certificate, and distributing via third-party stores. The victim installs what looks like their bank's app but runs a credential-harvesting overlay — a technique seen in the BankBot trojan family.

## Key facts
- APKs contain `AndroidManifest.xml` (declares permissions, components, and entry points), `classes.dex` (Dalvik bytecode), `resources.arsc`, native libraries (`lib/`), and a `META-INF/` folder holding the digital signature
- Android enforces **signature-based trust**: every APK must be signed; the OS checks the certificate on updates but does not require a trusted CA, enabling self-signed malware
- **Sideloading** — installing APKs outside the Google Play Store — bypasses Google's Play Protect scanning and is a primary malware delivery vector
- `apktool` disassembles APKs to Smali; `jadx` decompiles `classes.dex` to readable Java — both are standard tools in mobile penetration testing
- The **minimum SDK version** declared in the manifest can reveal whether an app deliberately targets older, exploitable Android versions

## Related concepts
[[Mobile Application Security]] [[Smali Bytecode]] [[Code Signing]] [[Sideloading]] [[Reverse Engineering]]