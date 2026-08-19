---
description: Gather the source material a chapter needs
argument-hint: "[chapter id, e.g. ch04 — or 'all' for every chapter missing research]"
---

Research: $ARGUMENTS

Dispatch `chapter-researcher`, one per chapter. These parallelise freely — launch
them in a single message.

Each reads its chapter's brief, gathers from primary sources, and writes
`research/notes/<topic>.md` plus rows in `research/sources.md`. It adds the note
path to the chapter's `research` list in `book.toml`.

Notes are facts with attribution, not finished prose — prose in a note gets copied
into the chapter, and then the chapter is in the researcher's voice rather than
the style guide's. Quote identifiers exactly. Date anything that decays. Record
what could not be established, and what was ruled out and how.
