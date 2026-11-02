---
description: Review the joins between adjacent units — one seam-reviewer per seam, in parallel
argument-hint: "[optional — 'script' for an audiobook's spoken layer, or seam ids like ch03__ch04]"
---

Review seams: $ARGUMENTS

```bash
python3 scripts/longform.py seams              # or: seams --layer script
```

That cuts every adjacent drafted pair into `review/seams/<a>__<b>.md`: the tail
of A, the head of B, and both briefs' Seams sections. Dispatch one
`seam-reviewer` per seam file (or only the ones named) **in a single message**.
Each reads its seam file only, never the manuscripts.

Then collect the reviews. For each finding, send the edge edit to the owning
unit's writer (the last paragraph or two of A, or the first one or two of B).
Findings addressed to `outline` go to the briefs before more units are drafted.
Re-cut and re-review any seam that was edited. `lint` flags seam reviews that
predate an edit.
