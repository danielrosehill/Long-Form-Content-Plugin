---
description: Design the structure and write one brief per chapter
---

Design the work.

Dispatch the `outline-architect` subagent, following the `planning` skill.

It produces `outline/outline.md`, the chapter entries in `longform.toml`, and — the
load-bearing artefact — one brief per chapter in `outline/briefs/`.

Three things to hold it to:

- **The outline never ships.** Not as a preface, not as chapter zero.
- **Every brief has a "must not cover" section**, and every boundary between two
  chapters is written into both of their briefs.
- **Neighbour summaries** are present, because they are what a writer gets
  instead of reading the chapters either side.

Then `python3 scripts/longform.py scaffold && python3 scripts/longform.py lint`.
