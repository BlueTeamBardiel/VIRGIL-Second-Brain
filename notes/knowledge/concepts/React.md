# React

## What it is
Like a smart dashboard that only redraws the gauges that change — rather than reprinting the entire panel — React is a JavaScript UI library that updates only the specific DOM elements affected by state changes. It uses a virtual DOM to efficiently reconcile and render dynamic web interfaces built from reusable components.

## Why it matters
React applications that improperly sanitize user-controlled props can be vulnerable to Cross-Site Scripting (XSS) — specifically when developers use `dangerouslySetInnerHTML` to render raw HTML, bypassing React's built-in output encoding. An attacker injecting malicious script through an unsanitized input field can steal session tokens or perform actions on behalf of authenticated users. Security teams auditing React codebases specifically hunt for this anti-pattern during code reviews.

## Key facts
- React escapes JSX output by default, making it **resistant to reflected XSS** — but `dangerouslySetInnerHTML` disables this protection entirely
- **Client-side routing** in React SPAs (Single Page Applications) can bypass server-side access controls if authorization is only enforced in the UI layer, not the API
- React applications often rely on **JWT tokens stored in localStorage**, which is accessible to JavaScript and therefore vulnerable to XSS-based token theft
- **Third-party npm packages** in React dependency chains are a supply chain attack vector — compromised packages (e.g., event-stream incident) can exfiltrate data silently
- Server-Side Rendering (SSR) with React (via Next.js) can introduce **prototype pollution** vulnerabilities if user input reaches server-side object merging operations

## Related concepts
[[Cross-Site Scripting (XSS)]] [[Content Security Policy]] [[Supply Chain Attack]] [[JSON Web Tokens]] [[Single Page Application Security]]