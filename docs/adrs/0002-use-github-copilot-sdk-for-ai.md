# Use GitHub Copilot SDK for AI

* Status: Proposed
* Date: 2026-04-20

## Context and Problem Statement

Naked Products is an AI-powered conversational agent. The application must
interact with users via natural language to guide them through a product
initialization workflow. This requires an AI SDK that provides conversational
capabilities, streaming responses, and tool-calling (function-calling) to
execute actions such as creating repositories or generating documents.

The product is deeply integrated with GitHub — it authenticates via the GitHub
CLI, creates GitHub repositories and projects, and targets GitHub users as its
primary audience. The AI integration should align with this GitHub-first
identity.

## Decision Drivers

* The AI backend must support multi-turn conversational chat with streaming
  responses for a responsive TUI experience.
* The AI SDK must support tool calling so the agent can execute actions
  (GitHub API calls, file creation) during a conversation.
* Authentication should leverage the existing GitHub CLI authentication
  rather than requiring a separate API key.
* The SDK should work well within the Node.js 24 + TypeScript ecosystem
  established in
  [ADR-0001](0001-use-nodejs-24-and-typescript.md).

## Considered Options

* GitHub Copilot SDK
* OpenAI Node.js SDK (direct API access)
* Anthropic Claude SDK
* LangChain.js

## Decision Outcome

Chosen option: "GitHub Copilot SDK", because it provides native GitHub
integration, leverages the user's existing GitHub Copilot subscription
without a separate API key, and is the first-party SDK for GitHub's AI
platform.

### Consequences

* Good, because users who already have a GitHub Copilot subscription can
  use Naked Products without any additional API keys or billing setup.
* Good, because the SDK authenticates using the GitHub CLI token, which
  aligns with the design principle of leveraging existing tools.
* Good, because GitHub Copilot is a familiar AI assistant for the target
  audience of developers.
* Good, because the SDK supports streaming responses and tool/function
  calling, which are required for the conversational TUI.
* Neutral, because users without a GitHub Copilot subscription cannot use
  the AI features until they subscribe.
* Bad, because the product is dependent on GitHub Copilot's availability
  and pricing changes.

## Pros and Cons of the Options

### GitHub Copilot SDK

* Good, because it integrates natively with GitHub's authentication and
  the existing `gh` CLI token.
* Good, because it targets the same audience (developers) who are likely
  to already have a Copilot subscription.
* Good, because first-party SDK support means it will be maintained
  alongside the GitHub Copilot service.
* Bad, because it requires a GitHub Copilot subscription, which not all
  users may have.

### OpenAI Node.js SDK

* Good, because OpenAI's API is mature, widely used, and well-documented.
* Good, because it supports streaming and tool calling.
* Bad, because it requires a separate OpenAI API key and billing account,
  adding friction for the user.
* Bad, because it has no native GitHub integration.

### Anthropic Claude SDK

* Good, because Claude has strong reasoning and writing capabilities well-
  suited to generating documents like PRDs and ADRs.
* Bad, because it requires a separate Anthropic API key and billing
  account.
* Bad, because there is no native GitHub integration.

### LangChain.js

* Good, because LangChain provides an abstraction layer that allows
  swapping AI backends.
* Bad, because LangChain adds significant complexity and abstraction
  overhead for what is a single-provider application.
* Bad, because LangChain's abstraction may not fully expose the
  capabilities of the GitHub Copilot SDK.
* Neutral, because LangChain could be layered on top of the Copilot SDK
  if provider flexibility is needed in the future.

## More Information

* [GitHub Copilot SDK](https://github.com/github/copilot-sdk)
* [GitHub Copilot pricing](https://github.com/features/copilot)
