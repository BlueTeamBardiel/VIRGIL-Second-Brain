# SDR / RF Knowledge — Master Index

> Source PDFs not yet available — notes pending ingest

## Planned Notes

The following PDFs were requested for ingest but were not found in `/home/your-username/Documents/` at the time of this session (2026-04-16):

| File | Target Note | Status |
|------|-------------|--------|
| `MIMO_for_HT_and_VHT.pdf` | [[mimo]] | ⏳ Pending PDF |
| `Media_Access_Control.pdf` | [[media-access-control]] | ⏳ Pending PDF |
| `Radio_Fundamentals.pdf` | [[radio-fundamentals]] | ⏳ Pending PDF |
| `Radio_components_and_maths.pdf` | [[radio-components]] | ⏳ Pending PDF |
| `Security_Architecture.pdf` | `../../security-plus/security-architecture` | ⏳ Pending PDF |
| `Signal_and_Antenna_theory.pdf` | [[signal-antenna-theory]] | ⏳ Pending PDF |

## Existing SDR Notes

- [[sdr/flock-alpr|Flock ALPR]] — automatic license plate reader network
- [[sdr/bvss-capture|BVSS Capture]] — RF capture and analysis

## Related Hardware

- [[CAIM]] — WiFi Pineapple MK7 (RF monitoring)
- [[RTL-SDR]] — USB SDR dongle for passive RF monitoring
- [[Flipper Zero]] — multi-protocol RF tool

## To Ingest

Drop the PDF files into `/home/your-username/Documents/` then run:

```bash
virgil-pdf /home/your-username/Documents/Radio_Fundamentals.pdf sdr
virgil-pdf /home/your-username/Documents/Radio_components_and_maths.pdf sdr
virgil-pdf /home/your-username/Documents/Signal_and_Antenna_theory.pdf sdr
virgil-pdf /home/your-username/Documents/MIMO_for_HT_and_VHT.pdf sdr
virgil-pdf /home/your-username/Documents/Media_Access_Control.pdf sdr
virgil-pdf /home/your-username/Documents/Security_Architecture.pdf security-plus
```

Or use the custom per-topic script (once written) for deeper section-level notes.