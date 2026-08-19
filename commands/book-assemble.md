---
description: Assemble the manuscript and hand off to print geometry
---

Assemble the book.

Follow the `book-publication` skill.

```bash
python3 scripts/book.py lint --strict
python3 scripts/book.py assemble
```

`--strict` first and it is not optional — an unresolved `[VERIFY:]` marker in a
printed reference work is not a style question, and print is not editable.

Produces `dist/manuscript.md` and `dist/manuscript.json`. Undrafted chapters
appear as comments rather than being silently omitted.

Then hand off to the plugin named in `[production] handoff` — by default
[`kdp-publishing`](https://github.com/danielrosehill/KDP-Publishing-Plugin) —
which owns trim, gutter, spine, cover wrap and pre-flight. Do not reimplement any
of that here; a cover must be built last, from the finished interior's measured
extent.
