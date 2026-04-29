# HTTP flood

## What it is
Imagine thousands of people repeatedly hitting "refresh" on a restaurant's online reservation page simultaneously — the server spends all its resources serving fake requests and can't respond to real customers. An HTTP flood is a Layer 7 (application-layer) DDoS attack where attackers send massive volumes of seemingly legitimate GET or POST requests to exhaust a web server's processing capacity, memory, or database connections.

## Why it matters
In 2016, the Mirai botnet leveraged HTTP flood techniques against Dyn DNS, taking down major sites including Twitter, Netflix, and Reddit for hours. Because the requests look like normal web traffic, traditional volume-based defenses like firewalls that inspect only packet headers largely failed — defenders had to implement rate limiting, CAPTCHA challenges, and behavioral analysis at the application layer to distinguish bots from humans.

## Key facts
- Operates at **OSI Layer 7**, making it harder to detect than volumetric floods (Layers 3/4) because packets appear legitimate
- **GET floods** request large static resources repeatedly; **POST floods** force the server to process complex database operations, amplifying resource consumption
- Effectiveness relies on **low bandwidth per attacker** — a single botnet node can cause damage with just a few hundred requests per second targeting expensive endpoints
- Mitigated via **rate limiting, Web Application Firewalls (WAF), CAPTCHA, IP reputation filtering**, and anomaly-based behavioral detection
- Distinguished from a **Slowloris attack** by request completion speed — HTTP floods fire complete, rapid requests rather than deliberately slow, partial ones

## Related concepts
[[DDoS Attack]] [[Botnet]] [[Web Application Firewall]] [[Slowloris Attack]] [[Rate Limiting]]