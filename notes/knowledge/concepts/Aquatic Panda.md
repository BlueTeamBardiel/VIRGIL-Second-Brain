# Aquatic Panda

## What it is
Think of a specialized burglary crew that only targets research labs and defense contractors — skilled, patient, and working for a specific government client. Aquatic Panda is a Chinese state-sponsored advanced persistent threat (APT) group, assessed to operate on behalf of Chinese intelligence, conducting cyberespionage against defense, telecommunications, and technology organizations globally.

## Why it matters
In December 2021, Aquatic Panda was caught mid-intrusion exploiting the Log4Shell vulnerability (CVE-2021-44228) against an academic institution, using their custom tooling to maintain persistence while analysts were actively patching systems. This incident highlighted that nation-state actors pivoted to exploit Log4Shell within days of disclosure — making rapid patching a national security imperative, not just a best practice.

## Key facts
- **Attribution**: Linked to China's People's Liberation Army (PLA) or associated contractors; also tracked as Bronze University and DoubleDouble Dragon by some vendors
- **Primary tools**: Uses custom malware including **Cobalt Strike**, **FishMaster** (custom RAT), and **njRAT** for command-and-control operations
- **TTPs**: Leverages Living-off-the-Land binaries (LOLBins), WMI for lateral movement, and credential dumping via LSASS memory
- **Targeting pattern**: Focuses on intellectual property theft from defense, energy, and biomedical research sectors — classic strategic intelligence collection
- **Log4Shell exploitation**: One of the first APT groups confirmed exploiting CVE-2021-44228 in the wild within 72 hours of public disclosure

## Related concepts
[[Advanced Persistent Threat (APT)]] [[Log4Shell (CVE-2021-44228)]] [[Living-off-the-Land Attacks]] [[Cobalt Strike]] [[Credential Dumping]]