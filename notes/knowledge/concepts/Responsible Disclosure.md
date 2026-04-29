# Responsible Disclosure

## What it is
Like a doctor who finds a dangerous medication error and privately notifies the hospital before alerting the press — giving them time to fix the problem without patients panicking — responsible disclosure is the practice of privately reporting a discovered vulnerability to the affected vendor, allowing a reasonable window (typically 90 days) to patch it before going public. It balances the researcher's obligation to warn the world against the vendor's need to protect users during remediation.

## Why it matters
In 2014, Google Project Zero discovered a critical Windows privilege escalation vulnerability and notified Microsoft privately. When Microsoft missed the 90-day deadline without shipping a patch, Project Zero published the technical details — creating pressure that accelerated the fix while also temporarily exposing users to risk. This case became a defining example of how deadline enforcement creates accountability without becoming weaponized.

## Key facts
- **Coordinated Vulnerability Disclosure (CVD)** is the formal NIST/ISO term (see NIST SP 800-216); "responsible disclosure" is the informal name for the same process
- The standard disclosure window is **90 days**, popularized by Google Project Zero; CISA recommends a similar timeline
- **Bug bounty programs** (HackerOne, Bugcrowd) formalize this process by offering financial rewards, creating legal safe harbors for researchers
- **Full disclosure** is the adversarial alternative — releasing exploit details immediately with no vendor notice, maximizing public pressure but maximizing risk
- Under the **Computer Fraud and Abuse Act (CFAA)**, researchers can face prosecution even when disclosing in good faith, making legal agreements with vendors critical before testing

## Related concepts
[[Bug Bounty Programs]] [[CVE Process]] [[Zero-Day Vulnerability]] [[Full Disclosure]] [[Coordinated Vulnerability Disclosure]]