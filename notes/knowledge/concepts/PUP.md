# PUP

## What it is
Like a "free" puppy that comes with unexpected vet bills, food costs, and chewed furniture — a Potentially Unwanted Program (PUP) is software that arrives bundled with something the user *did* want, but causes undesirable effects the user never explicitly agreed to. Technically, it's software that may compromise privacy, consume resources, or degrade performance, but doesn't rise to the level of outright malware because some form of (often buried) consent was obtained during installation.

## Why it matters
During a corporate security audit, analysts discovered that hundreds of workstations were exfiltrating browser history and search queries to third-party ad networks — traced back to a "free PDF converter" employees had installed. The PUP was technically disclosed in a 47-page EULA nobody read, making it legally gray but practically damaging, and standard AV initially missed it because it wasn't classified as malware.

## Key facts
- PUPs are distinct from malware in that *some* user consent exists (however obscured), but security tools like Windows Defender flag them using a separate detection category
- Common delivery vector: **bundleware** — piggybacking on legitimate freeware installers via pre-checked opt-in boxes
- Types include: adware (injects ads), browser hijackers (redirect search engines), fake system optimizers (scareware behavior), and toolbars
- Security+ classifies PUPs under the broader **potentially unwanted application (PUA)** taxonomy alongside spyware
- Detection relies on **heuristic and behavioral analysis** rather than pure signature matching, since PUPs mutate frequently to evade AV

## Related concepts
[[Adware]] [[Bundleware]] [[Spyware]] [[Browser Hijacking]] [[Social Engineering]]