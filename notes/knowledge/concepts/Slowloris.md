# Slowloris

## What it is
Imagine a customer who walks into a barbershop, sits down in the chair, and then just... pauses mid-sentence indefinitely — never finishing, never leaving, just occupying the seat forever while a line builds outside. Slowloris is a Layer 7 Denial-of-Service tool that exhausts a web server's connection pool by opening many HTTP connections and sending partial, never-completed requests at a painfully slow rate. Because the server keeps each connection alive waiting for the request to finish, it eventually runs out of available threads to serve legitimate users.

## Why it matters
In 2009, Slowloris was famously used against Iranian government websites during post-election protests, taking down servers with relatively minimal bandwidth — proving that volumetric firepower isn't always necessary. This attack is particularly dangerous because it can be launched from a single machine with low network traffic, making it hard to detect with traditional flood-based DDoS signatures.

## Key facts
- Slowloris operates entirely at **Layer 7 (Application Layer)** of the OSI model, not the network layer
- It exploits servers with **limited concurrent connection pools** — Apache was historically vulnerable; Nginx (event-driven) is largely resistant
- The attack sends **partial HTTP headers** with periodic keep-alive packets to prevent timeout, never completing the GET/POST request
- Mitigation strategies include: **connection rate limiting**, reducing connection timeout thresholds, load balancers, and reverse proxies
- Because traffic looks like slow legitimate users, it can **evade volumetric DDoS detection** — threshold-based alerting often misses it entirely
- Classified as a **low-and-slow attack**, consuming server resources without generating suspicious traffic spikes

## Related concepts
[[Denial of Service]] [[Application Layer Attacks]] [[HTTP Flood]] [[Rate Limiting]] [[Connection Exhaustion]]