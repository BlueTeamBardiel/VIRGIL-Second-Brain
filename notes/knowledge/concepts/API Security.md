# API Security

## What it is
Think of an API like a restaurant's service window: it's the designated opening where orders go in and food comes out — but if there's no bouncer checking who's allowed to order, anyone can reach through and grab from the kitchen. API security is the practice of authenticating, authorizing, and validating all requests made to application programming interfaces to prevent unauthorized access, data leakage, and manipulation of backend systems.

## Why it matters
In 2019, attackers exploited an unauthenticated Facebook API endpoint that allowed bulk phone number enumeration, ultimately scraping data from over 500 million accounts. The API accepted user IDs and returned associated phone numbers with no rate limiting or authentication — a classic case of Broken Object Level Authorization (BOLA), where the server never verified whether the requester *should* see the requested data.

## Key facts
- **OWASP API Security Top 10** is the primary reference framework; BOLA (API1) is the most critical vulnerability, where users can access objects belonging to other users by manipulating IDs in requests.
- **API keys are not authentication** — they identify an application, not a user; OAuth 2.0 with scoped tokens is the preferred authorization mechanism for user-delegated access.
- **Lack of rate limiting** enables brute-force, credential stuffing, and enumeration attacks; proper throttling and monitoring are mandatory controls.
- **Excessive Data Exposure** occurs when APIs return entire data objects and rely on the client to filter — always enforce server-side field filtering.
- For Security+/CySA+: API gateways function as a central enforcement point for authentication, logging, rate limiting, and TLS termination — treating the gateway as a perimeter control is a testable concept.

## Related concepts
[[OAuth 2.0]] [[Broken Access Control]] [[Input Validation]] [[Rate Limiting]] [[Zero Trust Architecture]]