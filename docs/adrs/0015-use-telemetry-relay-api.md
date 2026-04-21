# Use a Telemetry Relay API to Protect the GA4 Measurement Protocol Secret

* Status: Proposed
* Date: 2026-04-21

## Context and Problem Statement

[ADR-0007](0007-use-google-analytics-for-telemetry.md) chose Google
Analytics GA4 Measurement Protocol as the telemetry destination for
Naked Products but did not address how to protect the GA4 Measurement
Protocol API secret. Embedding the secret in a distributed CLI binary
(or container image) makes it trivially extractable: anyone who installs
the product can recover the secret by inspecting the artifact and then
inject arbitrary events into the maintainer's GA4 property.

A different approach is needed that preserves GA4 as the analytics
destination chosen in ADR-0007 while keeping the API secret out of
distributed artifacts entirely.

## Decision Drivers

* The GA4 Measurement Protocol API secret must not be present in
  distributed CLI binaries or container images.
* Secret rotation must not require shipping a new CLI release.
* The relay must not become a single point of failure that blocks
  normal CLI operation; telemetry sends must be best-effort and
  non-blocking.
* The relay should add minimal operational burden for the maintainer
  (serverless preferred).
* Users must retain full opt-out per ADR-0007 and PRD requirement
  PROD-020.

## Considered Options

* Embed the GA4 Measurement Protocol secret in the CLI binary
* Server-side telemetry relay on Azure Functions
* Server-side telemetry relay on AWS Lambda or Cloudflare Workers
* Drop GA4; use a fully self-hosted analytics solution (e.g., PostHog)
* No telemetry

## Decision Outcome

Chosen option: "Server-side telemetry relay on Azure Functions",
because it is serverless (no servers to operate), is low-cost at the
expected event volumes, has native Application Insights integration
for relay observability, and aligns with the maintainer's existing
tooling.

The relay accepts validated event payloads from the CLI over HTTPS and
forwards them to the GA4 Measurement Protocol with the API secret
applied server-side. The CLI never holds the GA4 secret. Relay
implementation, deployment, and monitoring are tracked in a separate
repository from the Naked Products CLI.

Telemetry sends from the CLI are fire-and-forget with a short timeout
(e.g., 2 seconds); failures are silently dropped to avoid affecting
the user experience.

### Consequences

* Good, because the GA4 Measurement Protocol secret is never
  distributed in any CLI artifact.
* Good, because secret rotation becomes a relay redeploy and does not
  require a CLI release.
* Good, because server-side validation can drop malformed or abusive
  payloads before they reach GA4.
* Good, because Application Insights gives the maintainer visibility
  into relay health independently of GA4.
* Neutral, because the project now has one additional piece of
  infrastructure to operate (mitigated by serverless hosting).
* Bad, because a relay outage means telemetry is silently lost
  (acceptable — telemetry is best-effort by design and must never
  block the CLI).
* Bad, because initial v1.0 delivery may slip to v1.0.1 if the relay
  is not ready by 2026-09-01; PROD-020 priority is updated to reflect
  this.

## Pros and Cons of the Options

### Embed GA4 secret in the CLI binary

* Good, because no additional infrastructure is required.
* Good, because the CLI can post directly to GA4 with no extra hop.
* Bad, because the secret is trivially extractable from any
  distributed binary or container image.
* Bad, because rotating the secret would require shipping a new CLI
  release to every user.
* Bad, because a leaked secret enables anyone to pollute the
  maintainer's GA4 property with arbitrary events.

### Server-side telemetry relay on Azure Functions

* Good, because it is serverless with no servers to operate or patch.
* Good, because cost is negligible at the expected event volumes
  (consumption plan).
* Good, because Application Insights provides built-in relay
  observability.
* Good, because it aligns with the maintainer's existing Azure
  tooling and skills.
* Bad, because it adds one piece of infrastructure to operate,
  monitor, and pay for.

### Server-side telemetry relay on AWS Lambda or Cloudflare Workers

* Good, because both are serverless and would also keep the GA4
  secret server-side.
* Good, because Cloudflare Workers in particular has a generous free
  tier and global edge distribution.
* Bad, because the maintainer would need to adopt a new cloud
  platform and observability stack solely for this relay.
* Bad, because operational learning curve outweighs the marginal
  benefit over Azure Functions for this scale of workload.

### Drop GA4; use a fully self-hosted solution (e.g., PostHog)

* Good, because the maintainer would have full ownership of the
  collected data.
* Good, because PostHog has a Node.js SDK and well-defined event
  schema for product analytics.
* Bad, because self-hosting PostHog requires operating and
  maintaining a database and application server — significantly more
  burden than a relay function.
* Bad, because it would supersede the analytics-destination decision
  in ADR-0007 rather than amend it.

### No telemetry

* Good, because it fully respects user privacy with zero data
  collection.
* Good, because it eliminates the need for a privacy policy, consent
  flow, or any backend infrastructure.
* Bad, because the maintainer has no insight into how the product is
  used in the wild, making it harder to prioritize improvements and
  catch critical bugs.
* Bad, because it would supersede ADR-0007 rather than implement it
  safely.

## More Information

This ADR amends [ADR-0007](0007-use-google-analytics-for-telemetry.md)
by specifying that the Measurement Protocol API secret is held by a
relay rather than embedded in the CLI. ADR-0007 remains Proposed and
accurate as to the analytics destination.

* [Azure Functions documentation](https://learn.microsoft.com/azure/azure-functions/)
* [Application Insights for Azure Functions](https://learn.microsoft.com/azure/azure-functions/functions-monitoring)
* [GA4 Measurement Protocol documentation](https://developers.google.com/analytics/devguides/collection/protocol/ga4)
