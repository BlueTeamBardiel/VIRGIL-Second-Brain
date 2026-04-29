# OpenTelemetry

## What it is
Like a universal flight recorder that works in every aircraft manufacturer's plane, OpenTelemetry is a vendor-neutral, open-source framework that standardizes how applications collect and export telemetry data — specifically traces, metrics, and logs. It provides a single set of APIs, SDKs, and agents so organizations avoid lock-in to any one monitoring vendor while still capturing rich observability data across distributed systems.

## Why it matters
During a supply chain attack like SolarWinds, defenders desperately needed correlated traces showing exactly how malicious code moved laterally between services. Organizations using OpenTelemetry could feed standardized trace data into any SIEM or observability platform simultaneously, enabling faster detection of anomalous service-to-service calls that indicated credential harvesting — without being locked into a single vendor's blind spots.

## Key facts
- OpenTelemetry is a CNCF (Cloud Native Computing Foundation) project merging OpenCensus and OpenTracing into one standard
- The three pillars it standardizes are **traces** (request flow across services), **metrics** (numeric measurements over time), and **logs** (timestamped event records)
- It outputs to the **OTLP (OpenTelemetry Protocol)**, which can forward to Splunk, Elastic, Datadog, Jaeger, or any compatible backend
- From a security standpoint, distributed traces can expose **lateral movement** and **abnormal API call chains** that endpoint tools miss entirely
- Auto-instrumentation agents can be injected without code changes, but this also means a compromised agent becomes a **privileged telemetry interception point** — a legitimate attack surface

## Related concepts
[[SIEM]] [[Distributed Tracing]] [[Log Management]] [[Supply Chain Attacks]] [[Security Monitoring]]