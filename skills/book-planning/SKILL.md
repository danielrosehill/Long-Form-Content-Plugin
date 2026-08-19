---
name: book-planning
description: Run the planning stage — write the style guide, design the structure, and produce one brief per chapter. Use after the spec is settled and before any drafting.
---

# Planning

The stage that makes parallel drafting possible. Everything the writing team does
well or badly is decided here.

```
voice-designer  →  outline-architect
style guide        outline + briefs + manifest
```

Style guide first: prose conventions affect chapter sizing, and an outline built
before the voice is settled gets re-cut.

## The output that matters

Three artefacts, and the third carries the load:

1. `guides/style-guide.md`
2. `outline/outline.md` — arc, chapter map, boundaries, drafting order
3. **`outline/briefs/<id>-<slug>.md` — one contract per chapter**

Plus the chapter entries in `book.toml`, which is structure of record.

## Why the brief is load-bearing

A chapter writer reads its brief, the style guide, its research notes and the
continuity ledger. It reads **no other chapter**. So everything that would
otherwise come from reading adjacent chapters has to be in the brief — including
the neighbour summaries and, above all, **must not cover**.

If briefs are thin, writers compensate by reading, and the architecture collapses
back into one large context without anything visibly failing.

Judge a brief by asking: could someone who has never seen this book write this
chapter from it, and would the result sit correctly beside its neighbours?

## Boundaries

For every pair of chapters that could plausibly both cover something, decide the
owner and write it into **both** briefs — "must cover" in one, "must not cover" in
the other. Undecided boundaries are where duplication comes from, and neither
writer will notice it.

## Continuity keys

Populate `establishes` and `requires` in `book.toml`. A chapter may only require
what an earlier chapter establishes.

```bash
python3 scripts/book.py scaffold   # stub anything the manifest declares
python3 scripts/book.py lint       # ordering, duplicates, missing files
```

## Drafting order is not chapter order

- **Best-sourced material first** — it sets the voice everything else is audited
  against, and the style guide gets corrected cheaply while only one chapter
  depends on it.
- **Most volatile facts last** — numbers decay, and drafting them early means
  drafting them twice.
- **Record which chapters cannot share a batch**: any two drawing on the same
  source for the same purpose.

Set `status = "outline"` when done.
