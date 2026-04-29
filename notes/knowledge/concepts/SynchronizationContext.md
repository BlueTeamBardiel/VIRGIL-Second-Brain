# SynchronizationContext

## What it is
Think of it like a traffic cop standing at a single-lane bridge — all cars (threads) must check in before crossing, and the cop decides when each one gets through. `SynchronizationContext` is a .NET abstraction that captures the threading environment of a caller (e.g., a UI thread or ASP.NET request context) and marshals continuations back to the correct thread after async operations complete.

## Why it matters
In web application security, improper `SynchronizationContext` handling in ASP.NET Classic could cause thread-context blitching — where a continuation resumes on a thread carrying *another user's* `HttpContext`, briefly exposing session tokens, identity claims, or request data to the wrong execution path. This is a subtle form of **data leakage between concurrent requests**, exploitable under high-load race conditions without any obvious vulnerability in business logic.

## Key facts
- `SynchronizationContext.Current` is inherited per-thread; if `ConfigureAwait(false)` is not used in library code, continuations unnecessarily re-enter the original context, creating bottlenecks and cross-request contamination risk.
- ASP.NET Core deliberately **removed** the legacy `AspNetSynchronizationContext`, eliminating an entire class of context-bleed bugs — a defense-by-design architectural decision.
- Race conditions exploiting synchronization primitives fall under **CWE-362 (Concurrent Execution Using Shared Resource with Improper Synchronization)**, directly testable in CySA+ scenarios.
- Attackers targeting thread-pool exhaustion (a form of DoS) deliberately trigger async deadlocks by forcing `.Result` or `.Wait()` calls inside synchronization contexts, starving the application.
- Secure coding guidelines (OWASP, Microsoft SDL) mandate `ConfigureAwait(false)` in all non-UI library async methods to prevent unintended context capture.

## Related concepts
[[Race Condition]] [[Thread Safety]] [[Denial of Service]] [[Insecure Direct Object Reference]] [[Concurrency Vulnerability]]