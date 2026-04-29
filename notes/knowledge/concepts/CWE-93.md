# CWE-93

## What it is
Like slipping a forged page into a letter so the mail server reads extra instructions you planted, CRLF Injection occurs when an attacker inserts carriage return (`\r`, CR) and line feed (`\n`, LF) characters into user-supplied input that gets embedded in an HTTP header. Because HTTP headers are delimited by these characters, injecting them lets an attacker terminate one header and write new ones — or even split the HTTP response entirely.

## Why it matters
An attacker targeting a login redirect might inject `\r\nSet-Cookie: session=attacker_value` into a `Location` header parameter, poisoning the victim's browser with a crafted session cookie. This technique, called **HTTP Response Splitting**, was the mechanism behind several real-world web cache poisoning attacks where malicious content was served to thousands of users from a shared proxy cache.

## Key facts
- CRLF sequences (`\r\n` / `%0d%0a`) are the standard HTTP header delimiter, making them the injection vector.
- The two primary attack outcomes are **HTTP Response Splitting** (injecting a fake second response) and **HTTP Header Injection** (adding rogue headers like `Set-Cookie` or `Location`).
- Downstream effects include **session fixation**, **cross-site scripting via header reflection**, and **web cache poisoning**.
- Proper defense requires stripping or encoding CR (`\r`) and LF (`\n`) characters from any user input before it is placed into HTTP response headers.
- Modern frameworks (e.g., newer versions of Python's `http` module, Java's Servlet API) raise exceptions on embedded CRLF in headers — but legacy or custom code remains vulnerable.

## Related concepts
[[HTTP Response Splitting]] [[CWE-113 HTTP Response Header Injection]] [[Web Cache Poisoning]] [[Session Fixation]] [[Input Validation]]