---
name: review
description: Run the review team over drafted units: proofreading, voice-drift audit, continuity audit and seam review. Use after drafting and before production. Skippable by explicit user choice; the mechanical gates are not.
---

# Review

Four reviewers, each with a narrow remit and a small working set. All four
write findings; **none of them edits prose.**

| Agent | Remit | Reads |
| --- | --- | --- |
| `proofreader` | Mechanical correctness, per unit | One unit, style guide |
| `voice-auditor` | Drift from the style guide | Samples across units |
| `continuity-auditor` | Repetition, contradiction, unpaid promises, whole-work | Lint output, ledger, summaries |
| `seam-reviewer` | The join between two adjacent units | One seam file |

## Reviewers do not edit

A reviewer that edits prose is a second author with no brief, and its changes are
invisible in a way an author's are not. They appear in no report, and nobody
knows the unit now says something different. Findings go to `review/reports/`
or `review/seams/`, and the unit's writer applies them.

## Seams are their own pass

The continuity auditor works over the whole work from the ledger. It finds the
term defined twice in chapters three and nine. It does not look at the joins,
and the joins are where work written by agents that never read each other breaks
first: unit N+1 re-introduces what N just said, both sides recap, N+1 opens from
a state N never reached, or the register jumps at the cut.

```bash
python3 scripts/longform.py seams          # review/seams/<a>__<b>.md, one per adjacent drafted pair
```

Dispatch one `seam-reviewer` per seam file, all in a single message. Each reads
its seam file (a few hundred words a side, plus both briefs' Seams sections)
and writes `review/seams/<a>__<b>.review.md`. Findings name one owning side, or
`outline` when the boundary itself was never decided.

Apply seam fixes as **edge edits**: the last paragraph or two of A, the first one
or two of B. Send each to the owning unit's writer with the finding. After a fix,
re-cut that seam and re-review it. `lint` warns when a seam review predates an
edit to either side, and when both sides are `reviewed` but the seam never was.

Run seams after each drafting batch that produces adjacent pairs, not only at the
end. A seam finding addressed to the outline means a brief's boundary was wrong,
and undrafted units may share the same fault.

## Running the rest

`proofreader` runs per unit and parallelises freely.

`voice-auditor` and `continuity-auditor` run once over the drafted set. Run them
after several units exist, not after all of them. Voice drift found at chapter
four is a style guide correction; found at chapter thirty it is thirty rewrites.

## This stage is skippable

By **explicit user choice**, not by default. Ask, and record the answer. Seam
review is the cheapest pass and the one that most changes how the finished work
reads, so if only one pass is kept, keep that one.

## The mechanical gates are not skippable

```bash
python3 scripts/longform.py lint --strict
```

## What review cannot do

`lint` checks that a source is cited, never that it says what the unit claims.
No reviewer here verifies facts. Someone has to read the work against reality.
Say so plainly rather than letting a clean set of reports imply otherwise.
