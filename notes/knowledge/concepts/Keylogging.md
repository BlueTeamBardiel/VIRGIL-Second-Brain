# keylogging

## What it is
Like a stenographer hiding under your desk, transcribing every word you type without your knowledge — keylogging is the technique of silently recording all keystrokes on a system, capturing passwords, credit card numbers, and private messages before encryption can protect them. It operates at the input layer, intercepting data *before* it ever reaches the application.

## Why it matters
In the 2016 Bangladesh Bank heist, attackers deployed keyloggers on SWIFT terminal workstations to harvest operator credentials, which were later used to authenticate fraudulent $1 billion transfer requests. This illustrates why endpoint detection matters even when network traffic is encrypted — by the time data hits the wire, the damage is already done.

## Key facts
- **Two main types:** Software keyloggers (user-space or kernel-level) and hardware keyloggers (physical devices plugged between keyboard and USB/PS2 port — invisible to OS scans)
- **Kernel-level keyloggers** are the most dangerous; they hook into the OS at ring 0, making them nearly undetectable by user-space antivirus tools
- **Anti-keylogging countermeasures** include virtual on-screen keyboards, two-factor authentication (keylogged passwords alone are insufficient), and behavioral EDR solutions that flag suspicious API hooking
- **Common delivery vectors:** Trojans, RATs (Remote Access Trojans), and malicious browser extensions — often arriving via phishing emails
- On Security+/CySA+, keyloggers are classified as **spyware**, a subcategory of malware, and are tested under both malware types and insider threat scenarios

## Related concepts
[[spyware]] [[rootkit]] [[credential harvesting]] [[endpoint detection and response]] [[RAT]]