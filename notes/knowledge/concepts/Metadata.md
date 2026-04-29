# metadata

## What it is
Like the library card sleeve inside a book — it doesn't contain the story, but it records who checked it out, when, and how often — metadata is data that describes other data. Precisely: metadata is structured information about a file, message, or object that includes details like author, timestamps, geolocation, device identifiers, and version history without necessarily revealing the content itself.

## Why it matters
In 2012, John McAfee's hiding location in Belize was exposed when journalists published a photo of him — the EXIF metadata embedded in the JPEG revealed the exact GPS coordinates where the photo was taken. Attackers routinely use tools like ExifTool or FOCA to harvest metadata from publicly available documents (PDFs, Word files, images) to map internal usernames, software versions, and network paths before ever touching a target's systems.

## Key facts
- **EXIF data** in images can contain GPS coordinates, camera model, timestamp, and software used — all harvestable without network access
- **Document metadata** (Word, PDF) often leaks author names, company names, revision history, and internal file paths — directly useful for reconnaissance
- **Email headers** are metadata — they reveal sending mail servers, client software, IP hops, and timestamps even when the body is encrypted
- **Metadata stripping** is a required step before publishing sensitive documents; tools like `mat2` or Adobe's built-in sanitization are used for this
- Under **GDPR and HIPAA**, metadata about communications and health records is treated as personally identifiable information (PII) and requires the same protection as content

## Related concepts
[[OSINT]] [[EXIF data]] [[reconnaissance]] [[data sanitization]] [[PII]]