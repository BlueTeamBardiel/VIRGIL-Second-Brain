# SMB

## What it is
Think of SMB like a shared filing cabinet in an office — any authorized employee can open it, drop in files, or grab what they need, all over the network. Server Message Block (SMB) is a network file-sharing protocol that allows systems to share files, printers, and named pipes across a network, operating primarily over TCP port 445.

## Why it matters
In 2017, the **WannaCry ransomware** exploited EternalBlue, an NSA-developed exploit targeting a critical vulnerability in SMBv1 (MS17-010). It spread laterally across networks without any user interaction, encrypting files on hundreds of thousands of machines globally — a textbook example of why legacy protocol versions must be disabled aggressively.

## Key facts
- SMB runs over **TCP port 445**; legacy implementations also used ports 137–139 (NetBIOS)
- **SMBv1** is dangerously outdated and should be disabled — it lacks encryption and is the target of EternalBlue; SMBv2 and v3 added signing, encryption, and performance improvements
- **SMB Relay attacks** intercept NTLM authentication handshakes and replay them to authenticate to other systems without cracking the password
- **Null sessions** (anonymous SMB connections) in older Windows environments could expose share names, user lists, and group policies — a goldmine for reconnaissance
- SMB signing, when enforced, prevents relay attacks by cryptographically binding authentication to a specific session

## Related concepts
[[NTLM Authentication]] [[Pass-the-Hash]] [[Lateral Movement]] [[EternalBlue]] [[NetBIOS]]