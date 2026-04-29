# Threat Qualification

## What it is
Like a triage nurse who separates a sprained ankle from a cardiac arrest before any treatment begins, threat qualification is the process of evaluating a detected threat to determine whether it is real, relevant, and worthy of a full incident response. It transforms a raw alert into an actionable determination — credible threat or false positive — before resources are committed.

## Why it matters
During a SOC investigation, an IDS fires 400 alerts in one hour following a misconfigured scanner sweep. Without threat qualification, analysts chase every alert and burn out; with it, they rapidly assess indicators against asset criticality, attack feasibility, and environmental context to confirm only three alerts represent actual lateral movement by an attacker. This triage prevents alert fatigue from masking a genuine breach.

## Key facts
- Threat qualification evaluates three core dimensions: **credibility** (is the source and evidence reliable?), **relevance** (does it target assets you actually own?), and **severity** (what's the potential impact if real?)
- It is distinct from **threat validation** — qualification asks "is this worth pursuing?" while validation confirms whether a specific vulnerability or attack path truly exists
- The **Diamond Model** and **MITRE ATT&CK** are commonly used frameworks to contextualize and qualify threat intelligence during this process
- **False positive rate** is a key metric; over-qualification (ignoring real threats) and under-qualification (chasing noise) both degrade security posture
- On CySA+ exams, threat qualification is often paired with **threat intelligence feeds** — candidates must know how to assess feed quality (timeliness, accuracy, relevance) as part of the qualification process

## Related concepts
[[Alert Triage]] [[Threat Intelligence]] [[False Positive Analysis]] [[MITRE ATT&CK]] [[Incident Response]]