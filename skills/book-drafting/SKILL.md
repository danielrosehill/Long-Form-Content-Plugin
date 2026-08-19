---
name: book-drafting
description: Dispatch chapter-writing subagents in parallel batches to draft the book, and handle research where a chapter's sources are not yet gathered. Use once briefs exist. Enforces the batching rule that keeps parallel writers from colliding.
---

# Drafting

Chapters are drafted by subagents working in parallel, one chapter each. You are
the orchestrator; you do not write chapters yourself.

## Before dispatching

1. `python3 scripts/book.py lint` — a structural problem found now is cheap.
2. Check each target chapter has a complete brief. A thin brief returns an
   unusable chapter, and by then other chapters have been drafted against it.
3. Check `research` in `book.toml`. Where a chapter's sources are not gathered,
   run **`chapter-researcher`** for it first. Research can run in parallel freely.

## The batching rule

Writers run concurrently. There is exactly one constraint:

> **Two chapters that draw on the same source material for the same purpose must
> not be drafted in the same batch.**

Two agents handed the same source will describe it differently — different
emphasis, different terminology, different depth — and both descriptions will
ship. Neither agent did anything wrong, and no reviewer looking at one chapter
will catch it.

So before each batch, compare the `research` and `establishes` lists across the
chapters you are about to dispatch. Overlaps go in **separate, sequential**
batches. The later batch's writers then have the earlier batch's ledger entries,
which is exactly what resolves the conflict.

## Dispatching

Launch a batch in a single message with multiple tool calls so they run
concurrently. Each `chapter-writer` gets its chapter id and nothing else it does
not need — it reads its own brief.

Follow the recommended drafting order in the outline, not chapter order.

## Writes are scoped

A writer writes `manuscript/<its chapter>.md` and its own rows in `continuity.md`.
Nothing else. Fan out freely on reading; keep writes disjoint.

## After each batch

- `python3 scripts/book.py status`
- `python3 scripts/book.py lint` — cross-chapter repetition, continuity ordering,
  unresolved markers, figure references
- **Read the returned chapters yourself.** A subagent's output is a report to be
  checked, not an established fact. Lint catches fabricated *paths*; it cannot
  catch a fabricated *claim* about something that does exist.
- Collect every `[VERIFY:]` marker into `research/sources.md` under Unresolved.

## When a writer pushes back

A writer that says it cannot write its chapter without reading another one has
found a real defect **in the brief**. Fix the brief. Do not grant it the other
chapter — that is the one rule the architecture cannot spend.
