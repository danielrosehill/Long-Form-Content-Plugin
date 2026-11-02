---
name: definition
description: Run the definition stage of a long-form project (book, report, screenplay or audiobook) — record the brief verbatim, interview for the gaps, and settle the spec. Use at the start of a project, before any planning or outlining.
---

# Definition

The stage that decides whether the book is worth writing and what it is. Three
agents, run in order, and the order matters.

```
brief-recorder  →  spec-interviewer  →  spec-writer
records only       asks only the gaps    settles it
```

## Why three agents and not one

**Recording and questioning are separated on purpose.** An agent that records and
interrogates in the same turn leads the witness: it asks about what it has
already decided is interesting, and what gets preserved is the record of that
conversation rather than of what the user came in wanting.

The brief as given is evidence. Once paraphrased into a spec, the original
framing — what was emphasised, what was assumed, what was left out — is
unrecoverable. It also makes the spec auditable: anything in the spec that cannot
be traced to the brief is an addition, and additions should be visible as
additions rather than passing as the user's requirements.

## Running it

1. **`brief-recorder`** → `spec/brief.md`. Asks nothing. If the user's brief is
   vague, it records a vague brief.
2. **`spec-interviewer`** → `spec/interview.md`. Reads the brief first, then asks
   only questions whose answers change the outline, the voice or the scope — in
   one batch, numbered.
3. **`spec-writer`** → `spec/spec.md`, plus `[project]` in `longform.toml` and
   `status = "spec"`.

Each is a separate invocation. Do not collapse them because it seems faster; the
separation is the point.

## What good looks like

The spec can settle an argument without asking the user again. When the outline
architect wonders whether a chapter belongs, the answer is in the spec.

The two sections that carry the most weight:

- **Out of scope** — what stops a twelve-chapter book becoming thirty during
  outlining. If the user did not say, derive it and put it up for confirmation.
- **What it must not become** — the version of this book the user would be
  embarrassed by. Rarely volunteered, always useful.

## Then stop

Definition ends at a settled spec. Report the open questions it does not close
rather than closing them by assumption. Planning is `/lf-style` and
`/lf-outline`, in that order.
