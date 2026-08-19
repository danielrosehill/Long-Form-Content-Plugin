---
name: book-review
description: Run the review team over drafted chapters — proofreading, voice-drift audit and continuity audit. Use after drafting and before publication. Skippable by explicit user choice; the mechanical gates are not.
---

# Review

Three reviewers, each with a narrow remit and a small working set. All three
write findings; **none of them edits prose.**

| Agent | Remit | Reads |
| --- | --- | --- |
| `proofreader` | Mechanical correctness, per chapter | One chapter, style guide |
| `voice-auditor` | Drift from the style guide | Samples across chapters |
| `continuity-auditor` | Repetition, contradiction, unpaid promises | Lint output, ledger, summaries |

## Reviewers do not edit

A reviewer that edits prose is a second author with no brief, and its changes are
invisible in a way an author's are not — they appear in no report, and nobody
knows the chapter now says something different. Findings go to
`review/reports/`; the chapter's writer applies them.

## Running it

`proofreader` runs per chapter and parallelises freely — separate chapters,
separate reports, no shared state.

`voice-auditor` and `continuity-auditor` run once over the drafted set. Run them
after several chapters exist, not after all of them: voice drift found at chapter
four is a style guide correction, and found at chapter thirty it is thirty
rewrites.

## This stage is skippable

By **explicit user choice**, not by default. Skipping is a decision about what the
book is for — a personal reference printed for one shelf and a book sold to
strangers do not warrant the same scrutiny. What matters is that the choice was
made rather than defaulted into. Ask, and record the answer.

## The mechanical gates are not skippable

```bash
python3 scripts/book.py lint --strict
```

Runs before production regardless. An unresolved `[VERIFY:]` marker in a printed
reference work is not a style question, and print is not editable.

## What review cannot do

`lint` checks that a source is cited, never that it says what the chapter claims.
No reviewer here verifies facts. A chapter can pass every check while making a
confident, specific, invented claim about a system that does not behave that way.

Someone has to read the book against reality. Say so plainly rather than letting
a clean set of reports imply otherwise.
