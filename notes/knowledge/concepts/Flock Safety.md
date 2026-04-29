# Flock Safety

## What it is
Think of it as a neighborhood watch program that never sleeps and has a photographic memory — Flock Safety is an automated license plate reader (ALPR) network that captures, timestamps, and stores vehicle data at fixed camera locations. Precisely: it is a commercial surveillance platform used by law enforcement and private communities that collects vehicle telemetry (plate numbers, make, color, direction of travel) and makes it searchable via a cloud-based portal.

## Why it matters
In multiple documented cases, law enforcement has used Flock Safety data to reconstruct a suspect vehicle's movement across dozens of camera checkpoints without a warrant, raising Fourth Amendment concerns analogous to the *Carpenter v. United States* ruling on cell-site location data. From a defensive intelligence perspective, threat actors planning crimes have begun conducting counter-surveillance routes specifically to avoid known Flock camera locations, demonstrating that adversaries adapt to passive collection infrastructure.

## Key facts
- Flock Safety cameras store plate reads for **30 days** by default before automated deletion, though retention policies vary by agency contract.
- The platform uses **"Vehicle Fingerprint"** technology — identifying vehicles by make, model, color, and distinguishing features even when plates are obscured.
- Data is stored in **AWS cloud infrastructure**, making it a high-value target; a breach would expose precise movement patterns of entire communities.
- Law enforcement agencies can share data across jurisdictions through **"TALON" hotlists**, enabling multi-agency queries without individual warrants in many states.
- Classified as **passive OSINT collection infrastructure** — relevant to physical security assessments, insider threat investigations, and privacy impact analyses.

## Related concepts
[[License Plate Recognition (ALPR)]] [[Physical Security Controls]] [[OSINT]] [[Data Retention Policies]] [[Fourth Amendment and Digital Privacy]]