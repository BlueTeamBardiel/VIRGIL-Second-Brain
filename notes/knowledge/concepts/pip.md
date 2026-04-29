# pip

## What it is
Like a vending machine for code — you insert a package name and it automatically fetches, unpacks, and installs it from the internet. Precisely, `pip` (Pip Installs Packages) is Python's default package manager, pulling libraries from the Python Package Index (PyPI) and installing them into your environment.

## Why it matters
In 2022, attackers published hundreds of malicious packages to PyPI using **typosquatting** — naming packages nearly identically to popular libraries (e.g., `requets` instead of `requests`). Developers who mistyped a package name unknowingly installed credential-stealing malware, demonstrating how supply chain attacks exploit trusted package ecosystems.

## Key facts
- `pip install <package>` fetches code from PyPI by default with **no mandatory code signing or verification** — you are trusting the registry's integrity
- Malicious packages can execute arbitrary code **at install time** via `setup.py`, before you ever import or run them
- `pip install -r requirements.txt` installs all dependencies at once, making a single poisoned dependency file a high-value attack target
- Running `pip audit` scans installed packages against known CVE databases — a key defensive hygiene practice
- Privilege escalation risk: running `pip install` as root/Administrator installs packages system-wide, expanding the blast radius of a compromised package

## Related concepts
[[Supply Chain Attack]] [[Dependency Confusion]] [[Typosquatting]] [[Software Composition Analysis]]