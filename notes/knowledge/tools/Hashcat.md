# hashcat

## What it is
Like a locksmith with a thousand master keys trying every combination at superhuman speed, hashcat is a CPU/GPU-accelerated password recovery tool that attempts to reverse cryptographic hashes by systematically testing candidate passwords. It takes a hash value as input and uses various attack modes to find the original plaintext that produces that hash.

## Why it matters
During a penetration test, an attacker who dumps `/etc/shadow` from a compromised Linux system obtains hashed passwords — useless without the originals. Using hashcat with a wordlist like rockyou.txt, weak passwords like "Summer2023!" can be cracked in seconds, demonstrating why password complexity policies and slow hashing algorithms like bcrypt or Argon2 are non-negotiable defenses.

## Key facts
- Supports multiple attack modes: **dictionary** (wordlist), **brute-force**, **combinator**, **rule-based mutation**, and **mask attack** (e.g., `?u?l?l?l?d?d`)
- Leverages GPU parallelism — a modern GPU can test **billions of MD5 hashes per second**, vastly outpacing CPU-only tools
- Identifies hash types by numeric codes: MD5 = `-m 0`, NTLM = `-m 1000`, bcrypt = `-m 3200`; bcrypt's intentional slowness makes GPU acceleration far less effective
- **Rule-based attacks** apply transformation rules (capitalize, append numbers, substitute letters) to wordlist entries, mimicking how real users modify base passwords
- Operates entirely **offline** after hash extraction — no network traffic, no account lockouts, making detection difficult

## Related concepts
[[password hashing]] [[rainbow tables]] [[credential dumping]] [[dictionary attack]] [[salting]]