# QueryMine sms

## What it is
Like a jeweler using acid to test whether metal is gold or fool's gold, QueryMine SMS is a technique where attackers craft deliberate SMS queries to extract information from or probe SMS-based systems, APIs, or gateways. It refers to the systematic probing and enumeration of SMS infrastructure — including SMS APIs, two-factor authentication flows, and carrier gateways — to harvest data, enumerate valid accounts, or map system behavior through crafted message requests.

## Why it matters
In a real-world attack scenario, a threat actor targeting a bank's SMS-based OTP (One-Time Password) system may send thousands of QueryMine-style probes to the SMS gateway API to determine which phone numbers are registered, confirm account existence, or measure response timing differences that reveal valid versus invalid users. This enumeration phase directly enables subsequent credential stuffing or SIM-swapping campaigns. Defenders monitor for abnormal API call volumes and implement rate limiting to detect and disrupt this reconnaissance.

## Key facts
- SMS APIs (such as Twilio or Nexmo endpoints) are common QueryMine targets due to inconsistent error-message handling that leaks enumeration data
- Response-time differential attacks (timing oracle) can confirm valid phone numbers even when error messages are intentionally generic
- QueryMine activity often precedes SIM-swap fraud by providing attackers a confirmed list of target numbers linked to accounts
- Rate limiting, CAPTCHA enforcement on SMS trigger endpoints, and consistent API error responses (returning identical responses for valid/invalid inputs) are primary mitigations
- OWASP API Security Top 10 lists "Excessive Data Exposure" and "Lack of Resources & Rate Limiting" as the vulnerability classes most relevant to SMS query mining abuse

## Related concepts
[[SMS Spoofing]] [[API Enumeration]] [[SIM Swapping]] [[OTP Bypass]] [[Rate Limiting]]