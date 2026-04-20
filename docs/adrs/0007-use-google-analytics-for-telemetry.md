# Use Google Analytics GA4 for Telemetry

* Status: Proposed
* Date: 2026-04-20

## Context and Problem Statement

As the product maintainer, understanding how Naked Products is used in the
wild — which features are exercised, how often it is launched, on which
platforms, and where critical failures occur — is valuable for prioritizing
improvements. However, collecting this data carries privacy implications and
must be handled responsibly.

An opt-in telemetry system is needed that:

* Collects anonymous usage events and error reports
* Requires informed user consent before any data is transmitted
* Does not collect personally identifiable information (PII)
* Has no negative impact on the interactive TUI experience
* Does not require operating a separate telemetry backend

## Decision Drivers

* User consent must come first; no data is transmitted without an explicit
  opt-in from the user.
* The telemetry backend should not require the maintainer to operate
  additional infrastructure.
* All telemetry must be non-blocking and asynchronous to avoid degrading
  the TUI experience.
* No PII or sensitive data (file contents, paths, tokens) may be collected.
* The system must be easy to disable permanently via a CLI command.

## Considered Options

* Google Analytics GA4 Measurement Protocol
* Mixpanel
* PostHog (self-hosted or cloud)
* Custom telemetry server
* No telemetry

## Decision Outcome

Chosen option: "Google Analytics GA4 Measurement Protocol", because it
provides a serverless telemetry backend with no infrastructure to operate,
is a mature and well-supported platform, and the Measurement Protocol API
enables server-side event submission from a CLI tool.

All telemetry is opt-in only. Users are prompted on first launch and can
change their preference at any time via `nakedproducts telemetry --enable`
or `nakedproducts telemetry --disable`.

### Consequences

* Good, because GA4 requires no backend infrastructure from the maintainer.
* Good, because GA4 provides a dashboard for analyzing usage patterns,
  session duration, and feature adoption without custom tooling.
* Good, because the Measurement Protocol sends events server-side (no
  browser required), which is appropriate for a CLI tool.
* Good, because the opt-in model with a displayed privacy policy ensures
  full user transparency and regulatory compliance.
* Neutral, because GA4's event schema is designed for web/app analytics
  and requires careful mapping for CLI events.
* Bad, because Google Analytics data is stored on Google's infrastructure;
  privacy-conscious users may be uncomfortable even with opt-in.
* Bad, because the GA4 Measurement Protocol does not have a standard
  Node.js client library; the integration must use the HTTP API directly.

## Pros and Cons of the Options

### Google Analytics GA4 Measurement Protocol

* Good, because it is a free, hosted service with no infrastructure cost.
* Good, because it has a dashboard for exploring events out of the box.
* Good, because it supports server-side event submission via HTTP POST.
* Good, because anonymous client IDs can be generated locally without
  any account or identity linkage.
* Bad, because it is owned by Google; some users object to Google data
  collection even on an opt-in basis.
* Bad, because there is no official Node.js SDK; the HTTP API must be
  called directly.

### Mixpanel

* Good, because Mixpanel has excellent analytics dashboards and user
  journey analysis.
* Good, because it has a Node.js SDK.
* Bad, because Mixpanel has a free tier with data volume limits that
  may require a paid plan as usage grows.

### PostHog (self-hosted or cloud)

* Good, because PostHog is open source and can be self-hosted for
  full data ownership.
* Good, because PostHog has a Node.js SDK.
* Bad, because self-hosting PostHog requires operating and maintaining
  additional infrastructure.
* Bad, because PostHog cloud has pricing tiers; high usage could
  incur costs.

### Custom telemetry server

* Good, because it gives full control over data collection and storage.
* Bad, because it requires designing, building, hosting, and maintaining
  a backend service.
* Bad, because it introduces significant operational overhead for a
  side project.

### No telemetry

* Good, because it fully respects user privacy with zero data collection.
* Good, because it eliminates the need for a privacy policy or consent
  flow.
* Bad, because the maintainer has no insight into how the product is
  used, making it harder to prioritize improvements and catch critical
  bugs.

## More Information

* [GA4 Measurement Protocol documentation](https://developers.google.com/analytics/devguides/collection/protocol/ga4)
* [GA4 Measurement Protocol reference](https://developers.google.com/analytics/devguides/collection/protocol/ga4/reference)
