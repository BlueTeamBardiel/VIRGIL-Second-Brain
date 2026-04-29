# Viruses

## What it is
Like a biological virus that hijacks a cell's machinery to replicate itself, a computer virus is malicious code that **attaches itself to a legitimate host file** and executes when that file is opened. Precisely defined: a virus is self-replicating malware that requires human interaction to spread and must infect a host file (executable, document, or boot sector) to propagate.

## Why it matters
In 2017, the Melissa virus resurgence concept was demonstrated when macro viruses embedded in Microsoft Word documents spread via email attachments — when users opened the `.doc`, the macro executed, emailed itself to the first 50 Outlook contacts, and overwhelmed mail servers worldwide. Defenders respond by disabling macros by default and implementing email attachment sandboxing to detonate suspicious files before delivery.

## Key facts
- Viruses **require a host file** to exist — this distinguishes them from worms, which are self-contained and self-propagating without a host
- **Four infection types**: file infectors (attach to `.exe`/`.com`), boot sector viruses (target MBR), macro viruses (embedded in Office documents), and multipartite (attack both files and boot sector)
- Viruses require **human interaction** to trigger (opening a file, running a program) — automated spread without user action means you're dealing with a worm instead
- **Polymorphic viruses** mutate their signature with each replication to evade signature-based AV detection; **metamorphic viruses** completely rewrite their code
- On Security+/CySA+, viruses are consistently contrasted with worms and Trojans — know: **Virus = host + human trigger**, **Worm = no host + self-propagates**, **Trojan = disguise, no self-replication**

## Related concepts
[[Worms]] [[Malware]] [[Polymorphic Malware]] [[Macro Viruses]] [[Antivirus Signatures]]