# NietThijmen ShoppingCart

## What it is
Like a cashier who never checks whether the price tag on an item was swapped by a customer, NietThijmen ShoppingCart is a deliberately vulnerable web application designed for learning e-commerce security flaws. It is an intentionally insecure shopping cart project that demonstrates common web vulnerabilities such as price manipulation, insecure direct object references (IDOR), and improper input validation in a controlled practice environment.

## Why it matters
In real-world attacks, client-side price tampering is a well-documented threat: an attacker intercepts a purchase request using a proxy tool like Burp Suite, modifies the item price from $999 to $0.01, and submits it — if the server never validates pricing server-side, the order succeeds. NietThijmen ShoppingCart provides a safe sandbox to practice detecting and exploiting exactly this class of vulnerability before encountering it in a penetration test or bug bounty program.

## Key facts
- **Client-side trust violations**: The app demonstrates what happens when price or quantity values are stored in hidden HTML fields or cookies and trusted without server-side re-validation.
- **IDOR exposure**: Product and order IDs may be guessable integers, allowing one user to access or modify another user's cart or order data.
- **Input validation failures**: Fields may accept negative quantities or non-numeric values, potentially causing logic errors or unintended discounts.
- **Deliberate design**: Like DVWA or WebGoat, it is intentionally broken — running it in production would be catastrophic; it belongs only in isolated lab environments.
- **Relevant exam domain**: Maps to CompTIA Security+ domain covering application vulnerabilities (improper input handling, business logic flaws) and CySA+ threat intelligence/web app analysis.

## Related concepts
[[DVWA]] [[Insecure Direct Object Reference]] [[Business Logic Vulnerability]] [[Client-Side Validation Bypass]] [[Burp Suite]]