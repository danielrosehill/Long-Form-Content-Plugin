---
description: Run the review team — proofreading, voice drift, continuity
argument-hint: "[optional — chapter ids, or 'voice' / 'continuity' for a single pass]"
---

Review: $ARGUMENTS

Follow the `book-review` skill.

- `proofreader` — per chapter, parallelises freely
- `voice-auditor` — samples across chapters for register drift
- `continuity-auditor` — starts from `lint --json`, then the judgements the
  machine cannot make

**Reviewers write findings; they do not edit prose.** Findings go to
`review/reports/` and the chapter's writer applies them.

Run the voice audit once several chapters exist rather than waiting for all of
them — drift found at chapter four is a style guide correction, and found at
chapter thirty it is thirty rewrites.

This stage is skippable by explicit user choice. `lint --strict` is not.
