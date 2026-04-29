# data lifecycle management

## What it is
Think of data like fresh produce in a grocery store: it arrives, gets stocked, is actively used, eventually expires, and must be properly disposed of — leaving spoiled food on shelves causes real harm. Data lifecycle management (DLM) is the formal policy framework governing how data is created, stored, used, shared, archived, and destroyed throughout its useful life. It ensures that sensitive information doesn't linger in systems longer than necessary, reducing attack surface at every stage.

## Why it matters
In 2017, Equifax retained sensitive consumer records far beyond operational necessity due to poor lifecycle policies — when attackers breached their systems, 147 million records were exposed that arguably shouldn't have still existed in accessible form. A mature DLM policy would have enforced retention limits and triggered secure deletion, dramatically shrinking the blast radius. This is exactly why regulators like GDPR and HIPAA mandate defined retention and destruction schedules.

## Key facts
- **Five core phases**: Creation → Storage → Use → Sharing → Archival → Destruction (some frameworks split into six stages)
- **Data retention policies** define the minimum and maximum period data must be kept; violations can trigger legal liability or compliance failures
- **Secure destruction methods** vary by media: degaussing for magnetic drives, cryptographic erasure for SSDs (destroying encryption keys renders data unreadable), and physical shredding for paper
- **Data classification** must occur at creation — labels like Public, Internal, Confidential, and Restricted drive all downstream lifecycle decisions
- **Legal holds** can override normal destruction schedules during litigation, requiring preservation of data that would otherwise be purged

## Related concepts
[[data classification]] [[data retention policies]] [[cryptographic erasure]] [[information security governance]] [[media sanitization]]