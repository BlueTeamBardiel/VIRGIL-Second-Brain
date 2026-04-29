# npm

## What it is
Think of npm like a massive public library where any developer can donate books — but nobody checks if the books contain hidden razor blades. npm (Node Package Manager) is the default package manager for Node.js, hosting over 2 million open-source JavaScript packages that developers install as dependencies in their projects.

## Why it matters
In 2021, the `ua-parser-js` npm package was hijacked after an attacker compromised the maintainer's account, injecting a cryptominer and password-stealing trojan into a package downloaded millions of times per week. This supply chain attack demonstrates how a single compromised dependency can weaponize trusted software pipelines at scale — affecting companies like Facebook, Microsoft, and Google who used the package.

## Key facts
- **Dependency confusion attacks** exploit npm's resolution order: if a private internal package name is published publicly, npm may pull the malicious public version instead
- The `npm audit` command scans installed packages against the GitHub Advisory Database to identify known CVEs in dependencies
- **Typosquatting** is endemic on npm — packages like `lodash` get impersonated by `lodahs` or `1odash` targeting developers who mistype install commands
- npm packages use **semantic versioning (semver)** — the `^` and `~` operators in `package.json` allow automatic minor/patch updates, which can silently pull in malicious code if a package is compromised post-install
- The `package-lock.json` file pins exact dependency versions and hashes, serving as an integrity control against unexpected substitution attacks

## Related concepts
[[Supply Chain Attack]] [[Dependency Confusion]] [[Software Composition Analysis]]