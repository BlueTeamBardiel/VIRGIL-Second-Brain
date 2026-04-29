# Bambdas

## What it is
Think of Bambdas like custom filters you write in plain English for a search engine, except instead of searching the web, you're hunting through raw network traffic in Burp Suite. Bambdas are Java lambda expressions introduced in Burp Suite 2023.10 that allow security testers to write custom, programmatic filtering logic directly within the HTTP history and logger tabs. Rather than clicking dropdown menus, you write actual code that evaluates each HTTP request or response against conditions you define.

## Why it matters
During a web application penetration test, a tester might capture thousands of HTTP requests but only care about responses containing specific tokens, status codes combined with unusual content lengths, or requests hitting a particular endpoint with a specific parameter pattern. Bambdas let the tester write a single lambda expression like `requestResponse.response().statusCode() == 200 && requestResponse.response().body().toString().contains("admin")` to surface only the relevant traffic instantly — dramatically cutting analysis time and catching logic flaws that generic filters would miss.

## Key facts
- Bambdas use Java lambda syntax and are evaluated per `HttpRequestResponse` object within Burp Suite Pro/Enterprise
- They can access request method, headers, body, URL, response status code, response body, and MIME type programmatically
- Bambdas execute in real-time against live traffic in the Proxy HTTP History, Logger, and Search tabs
- A Bambda must return a **boolean** — `true` to display the item, `false` to hide it — making them purely filter functions
- They reduce false positives in manual testing by combining multiple conditional checks that dropdown filters cannot express simultaneously

## Related concepts
[[Burp Suite]] [[HTTP Interception Proxy]] [[Web Application Penetration Testing]] [[HTTP Request Smuggling]] [[Traffic Analysis]]