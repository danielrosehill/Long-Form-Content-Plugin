---
description: Draft chapters with parallel writing subagents
argument-hint: "[chapter ids, e.g. ch01 ch02 ch05 — or 'next' to follow the drafting order]"
---

Draft: $ARGUMENTS

Follow the `drafting` skill.

Before dispatching: run `lint`, confirm each target chapter has a complete brief,
and run `chapter-researcher` for any chapter whose sources are not gathered.

**Apply the batching rule.** Compare the `research` and `establishes` lists of the
chapters you are about to dispatch; any two drawing on the same source for the
same purpose go in separate sequential batches. Two agents given the same source
describe it differently and both descriptions ship.

Launch each batch in a single message. Each `chapter-writer` reads its own brief,
the style guide, its notes and the ledger — and no other chapter.

Afterwards: `status`, `lint`, and **read the chapters yourself**. Lint catches
fabricated paths; it cannot catch a fabricated claim about something that exists.
Collect every `[VERIFY:]` marker into `research/sources.md`.

Then cut and review the seams this batch created: `/lf-seams`.
