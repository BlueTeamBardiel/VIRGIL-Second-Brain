# 3CX supply chain attack

## What it is  
Imagine a trusted vending machine that delivers fresh drinks, but one day a tampered slot releases a harmful substance. A 3CX supply chain attack is when malicious actors compromise the software’s update or distribution channel to inject malware into legitimate 3CX IP‑PBX installers, turning a trusted product into a delivery mechanism for attackers.  

## Why it matters  
In late 2023, a compromised 3CX update bundle was used by a state‑backed group to install backdoors on corporate VoIP systems, giving them credential theft and lateral movement capabilities. Defenders who ignored update signing verification could not detect the hidden payload, illustrating how supply‑chain breaches can bypass traditional perimeter defenses.  

## Key facts  
- 3CX is a widely deployed on‑premises or cloud PBX used by over 100 k organizations.  
- Attackers compromised the vendor’s build server, inserting a “Trojan” DLL that exfiltrated SIP credentials.  
- The malicious update bypassed checksum checks because the vendor’s signing key was stolen.  
-