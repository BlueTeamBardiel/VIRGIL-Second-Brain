# Envoy

## What it is
Think of Envoy as a highly intelligent traffic cop standing at every intersection in a city, inspecting every vehicle, logging every route, and rerouting cars around accidents — except it operates between microservices. Envoy is an open-source, high-performance Layer 7 proxy and service mesh component originally built by Lyft, designed to handle inter-service communication in distributed architectures by managing load balancing, observability, and security policy enforcement at the network edge.

## Why it matters
In a zero-trust architecture, Envoy sidecars enforce mutual TLS (mTLS) between microservices, meaning even internal east-west traffic is encrypted and authenticated. A 2021 CVE (CVE-2021-32777) in Envoy allowed header normalization bypass attacks where crafted HTTP requests could circumvent authorization policies — demonstrating that even the traffic cop can be fooled if its input parsing is exploited. Defenders must keep Envoy updated and audit its access control policies in service mesh deployments like Istio or Consul.

## Key facts
- Envoy operates as a **sidecar proxy** in service meshes (e.g., Istio), sitting alongside each microservice container and intercepting all inbound/outbound traffic
- Supports **mutual TLS (mTLS)** for service-to-service authentication, a core zero-trust control
- Provides **L7 observability** — detailed HTTP, gRPC, and TCP telemetry including request tracing and access logs, critical for threat detection and incident response
- Envoy's **xDS (discovery service) API** dynamically pushes configuration changes, meaning a compromised control plane can silently alter routing and security policies cluster-wide
- Listed as a relevant technology in cloud-native security frameworks including **CNCF** and referenced in CySA+ cloud security domains

## Related concepts
[[Service Mesh]] [[Mutual TLS]] [[Zero Trust Architecture]] [[Sidecar Proxy]] [[Microservices Security]]