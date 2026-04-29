# PMSCT_RLE1

## What it is
Like a postal sorting system that bundles identical consecutive envelopes together to save truck space, PMSCT_RLE1 (Portable Map Steganographic Compression Transform – Run-Length Encoding variant 1) is a steganographic compression scheme that uses run-length encoding to embed hidden data within image or map file structures while maintaining plausible file integrity. It encodes payload data by manipulating the frequency and pattern of repeated pixel or data values across a carrier file.

## Why it matters
In covert command-and-control (C2) operations, threat actors have used RLE-based steganographic techniques to hide malicious instructions inside bitmap or portable map images distributed via public file-sharing sites, bypassing DLP controls that inspect only file extensions and headers. A defender analyzing anomalous outbound image traffic in a CySA+ scenario would look for statistical irregularities in RLE sequences that deviate from natural image compression patterns.

## Key facts
- RLE steganography exploits the predictable structure of run-length encoded data by inserting payload bits into run-count values without visibly distorting the image
- Detection relies on steganalysis tools that perform chi-square or RS analysis to identify non-random distributions in compressed data runs
- PMSCT_RLE1 specifically targets portable pixmap/greymap/bitmap (PBM/PGM/PPM) formats, which lack cryptographic integrity checks
- File size anomalies — carrier files larger than expected for their apparent visual content — are a common forensic indicator
- This technique can evade signature-based IDS/IPS if the carrier file's header and magic bytes appear legitimate

## Related concepts
[[Steganography]] [[Covert Channel]] [[Data Loss Prevention]] [[Steganalysis]] [[Command and Control (C2)]]