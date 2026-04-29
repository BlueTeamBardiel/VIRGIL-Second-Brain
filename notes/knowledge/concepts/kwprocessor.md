# kwprocessor

## What it is
Like a pianist who plays scales by sliding their hand across keys in predictable patterns, kwprocessor generates passwords by mapping keyboard walk sequences — adjacent key movements on physical keyboard layouts. It is a specialized wordlist generator that creates candidate passwords based on how users physically traverse keyboard geography (e.g., `qwerty`, `1qaz2wsx`, `qazwsx`).

## Why it matters
During a credential stuffing attack against a corporate VPN, an attacker uses kwprocessor to generate a targeted wordlist of keyboard-walk patterns before spraying them against harvested usernames. Because millions of users choose passwords like `1q2w3e4r` or `zxcvbn` believing they're being clever, kwprocessor-generated lists dramatically increase cracking success rates over generic dictionaries while staying under account-lockout thresholds through slow spraying.

## Key facts
- kwprocessor is a standalone tool (by hashcat's team) used in **password cracking pipelines**, typically feeding output into hashcat or john the ripper
- It supports **multiple keyboard layouts** including QWERTY, AZERTY, and QWERTZ, making it effective against international targets
- The tool accepts parameters for **walk length, direction, and starting character**, giving attackers fine-grained control over generated patterns
- Keyboard-walk passwords consistently appear in **top 10 most-used password lists** from breach dumps (e.g., RockYou dataset), validating this attack vector
- Defenders counter this by enforcing **password complexity policies that detect sequential keyboard patterns** — modern PAM solutions and password managers flag these patterns explicitly

## Related concepts
[[Password Spraying]] [[Hashcat]] [[Credential Stuffing]]