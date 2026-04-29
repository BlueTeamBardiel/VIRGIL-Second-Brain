# Cold Storage

## What it is
Like keeping your life savings in a safe buried in the backyard instead of a bank — physically isolated from any network. Cold storage is the practice of storing cryptographic private keys (especially for cryptocurrency or sensitive credentials) on hardware or media that has **never been connected to the internet**, making remote compromise impossible by design.

## Why it matters
In 2014, Mt. Gox lost 850,000 Bitcoin because private keys were stored in hot wallets connected to live systems — attackers exfiltrated keys remotely over time. Had those keys been in cold storage (air-gapped hardware wallets or paper wallets), no remote attacker could have touched them regardless of network-layer vulnerabilities.

## Key facts
- **Air-gap** is the physical mechanism that makes cold storage secure — no network interface, no Bluetooth, no wireless of any kind
- Common cold storage implementations include **hardware security modules (HSMs)** kept offline, **paper wallets** (printed QR codes of private keys), and dedicated offline signing devices
- Cold storage trades **availability** for **confidentiality** — accessing keys requires physical presence, making it resistant to remote attacks but slower for operational use
- **Signing transactions offline** is the secure workflow: unsigned transaction travels to the cold device, gets signed, then the signed transaction (not the key) travels back online
- Cold storage is relevant to the **CIA triad** exam questions specifically around protecting cryptographic material and key management lifecycle

## Related concepts
[[Air Gap]] [[Hardware Security Module]] [[Key Management]] [[Cryptographic Key Protection]] [[Hot Wallet]]