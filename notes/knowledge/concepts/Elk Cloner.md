# Elk Cloner

## What it is
Like a hitchhiker who jumps between cars at rest stops, Elk Cloner spread by quietly attaching itself to floppy disks whenever they were inserted into an infected Apple II computer. Created by 15-year-old Richard Skrenta in 1982, it is widely recognized as the first computer virus to spread "in the wild" — outside a controlled lab environment — using a boot sector infection mechanism.

## Why it matters
Elk Cloner established the foundational attack pattern that boot sector viruses would exploit for decades: infecting the master boot record so malicious code executes *before* the operating system loads, making detection and removal significantly harder. Modern UEFI Secure Boot was designed specifically to counter this class of threat by cryptographically verifying boot code before execution — a direct defensive lineage traceable back to Elk Cloner's mischief.

## Key facts
- Written by Richard Skrenta in 1982 as a prank; spread via infected Apple II floppy disks
- Infected the DOS 3.3 boot sector, activating on every 50th boot by displaying a short poem
- First virus documented spreading through a real-world population rather than in a lab (i.e., "in the wild")
- Caused no intentional data destruction — its payload was purely annoying (the poem display), but it demonstrated replication was possible without user awareness
- Predates the formal term "computer virus" by two years — Fred Cohen coined the term in 1984

## Related concepts
[[Boot Sector Virus]] [[UEFI Secure Boot]] [[Virus Payload]] [[Floppy Disk Attack Vector]] [[Malware History]]