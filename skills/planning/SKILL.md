---
name: planning
description: Run the planning stage — write the style guide, design the structure, and produce one brief per unit, including the Seams section that tells each writer where its neighbours leave off. Use after the spec is settled and before any drafting.
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

Plus the chapter entries in `longform.toml`, which is structure of record.

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

## Seams

Each brief's **Seams** section says what the unit picks up from and what it
hands off to. Write both sides of every join together, from the outline, so the
two lines agree. Then two writers who never read each other still meet. The
seam-reviewer later checks the drafted join against exactly these lines.

## Sizing by type

- **book / report**: by argument; one claim per unit.
- **screenplay**: a unit is a sequence (a run of scenes one writer can own,
  about five to fifteen pages). Cut at changes of time or place, never
  mid-scene. Populate the Characters, Locations and Timeline tables in
  `continuity.md` before drafting, so writers have fixed details from the start.
- **audiobook**: about 155 spoken words a minute. Chapters of 20 to 40 minutes
  (3,000 to 6,000 words) suit listeners. Every chapter must make sense to someone
  who skipped to it, so its brief carries one line of orientation.

## Continuity keys

Populate `establishes` and `requires` in `longform.toml`. A chapter may only require
what an earlier chapter establishes.

```bash
python3 scripts/longform.py scaffold   # stub anything the manifest declares
python3 scripts/longform.py lint       # ordering, duplicates, missing files
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
