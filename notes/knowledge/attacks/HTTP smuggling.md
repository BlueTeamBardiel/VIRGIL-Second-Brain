# HTTP smuggling

## What it is
Imagine two border guards checking the same luggage — one counts items by weight, the other by number — so a smuggler exploits their disagreement to hide contraband in the gap. HTTP smuggling works the same way: when a front-end proxy and a back-end server disagree on where one HTTP request ends and the next begins — specifically by interpreting `Content-Length` and `Transfer-Encoding: chunked` headers differently — an attacker can "prefix" a malicious request onto the back-end's queue, poisoning it for the next victim.

## Why it matters
In 2019, James Kettle demonstrated HTTP smuggling against major platforms including Netflix and Slack, achieving cache poisoning, credential hijacking, and reflected XSS against other users' sessions. Because the attack rides inside a legitimate-looking request, WAFs and intrusion detection systems sitting at the front-end typically never see the smuggled payload — it's invisible to them by design.

## Key facts
- **Two attack variants**: CL.TE (client sends `Content-Length`, back-end honors `Transfer-Encoding`) and TE.CL (reversed), each exploiting ambiguity in HTTP/1.1 header precedence
- **RFC 7230** states that if both headers are present, `Transfer-Encoding` takes priority — inconsistent implementation of this rule is the root cause
- Attackers can use smuggling to **bypass access controls**, poison shared connection queues, steal other users' requests (including session cookies), and perform **host header injection**
- HTTP/2 largely mitigates classic smuggling because it uses binary framing with explicit stream boundaries — but **H2.C downgrade attacks** reintroduce the vulnerability
- **Detection** involves sending deliberately ambiguous requests and timing differential responses; tools like Burp Suite's HTTP Request Smuggler extension automate this

## Related concepts
[[Transfer-Encoding Header]] [[Content-Length Header]] [[Request Smuggling Detection]] [[Reverse Proxy Architecture]] [[HTTP/2 Downgrade Attack]]