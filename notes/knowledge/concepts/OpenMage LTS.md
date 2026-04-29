# OpenMage LTS

## What it is
Think of it as a community-run life-support machine keeping a discontinued hospital system running safely after the manufacturer walked away. OpenMage LTS is a community-maintained fork of Magento 1 (which reached end-of-life in June 2020), providing ongoing security patches and bug fixes for the abandoned e-commerce platform.

## Why it matters
Thousands of online stores never migrated from Magento 1 after EOL, making them prime targets for Magecart-style attacks — malicious JavaScript skimmers injected into checkout pages to steal payment card data in real time. OpenMage LTS directly addresses this by backporting security patches and closing vulnerabilities like PHP object injection flaws (CVE-2022-24086 class) that attackers actively exploit against unpatched Magento 1 installations. Without it, merchants face PCI DSS compliance failures in addition to breach risk.

## Key facts
- Magento 1 officially reached End-of-Life on **June 30, 2020**, meaning Adobe ceased all security updates — OpenMage LTS fills that vacuum
- Magecart attacks targeting EOL Magento stores involve **supply-chain-style skimmer injection** via compromised third-party JavaScript or direct server compromise through known unpatched CVEs
- OpenMage LTS patches critical vulnerabilities including **PHP object deserialization** and **remote code execution** flaws that are weaponized in the wild
- Running EOL software like unpatched Magento 1 violates **PCI DSS Requirement 6.3.3** (all software components protected from known vulnerabilities)
- OpenMage is hosted on GitHub, enabling transparent, auditable patch history — a key trust mechanism differentiating it from unofficial or malicious "patch" packages circulating online

## Related concepts
[[Magecart Attack]] [[End-of-Life Software Risk]] [[Supply Chain Attack]] [[PCI DSS]] [[PHP Object Injection]]