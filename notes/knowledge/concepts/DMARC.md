# DMARC

## What it is
Think of DMARC as the post office's fraud department: it doesn't just check if a letter looks official — it calls the real sender to verify, then decides whether to deliver, quarantine, or burn suspicious mail. Technically, DMARC (Domain-based Message Authentication, Reporting, and Conformance) is a DNS-published email policy that instructs receiving mail servers how to handle messages that fail SPF or DKIM alignment checks. It also provides a feedback loop, sending aggregate and forensic reports back to the domain owner.

## Why it matters
Business Email Compromise (BEC) attacks frequently involve spoofing a CEO's exact domain — not a lookalike — to trick finance employees into wiring funds. Without DMARC set to `p=reject`, that spoofed email sails through even if SPF and DKIM exist, because there's no enforcement policy telling receivers what to do on failure. A properly configured DMARC record with `p=reject` would have the receiving server silently discard those fraudulent messages before they ever reach the inbox.

## Key facts
- DMARC policies have three enforcement levels: `p=none` (monitor only), `p=quarantine` (send to spam), and `p=reject` (block entirely)
- DMARC requires **alignment** — the domain in the `From:` header must match the domain authenticated by SPF or DKIM, not just any passing check
- Published as a DNS TXT record at `_dmarc.yourdomain.com`
- The `rua` tag specifies where **aggregate** reports go; `ruf` specifies **forensic** (per-message failure) reports
- DMARC builds *on top of* both SPF and DKIM — it provides the policy enforcement layer that neither protocol alone supplies

## Related concepts
[[SPF]] [[DKIM]] [[Email Spoofing]] [[DNS TXT Records]] [[Business Email Compromise]]