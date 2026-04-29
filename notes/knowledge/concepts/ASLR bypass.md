# ASLR bypass

## What it is
Imagine a library where every book’s location changes each day so a reader can’t predict where a specific title sits. In computing, ASLR (Address Space Layout Randomization) shuffles the memory locations of executables, libraries, stack, and heap so attackers can’t reliably target code or data. An ASLR bypass is a technique that defeats this shuffling, allowing the attacker to