---
description: Production stage — assemble and hand off (book), export PDF (report, screenplay); audiobooks go to /lf-narrate and /lf-render
---

Assemble the work.

Follow the `publication` skill, which branches on `[output] type`. For a
**report** or **screenplay**, run `longform.py export` after `assemble`. For an
**audiobook**, `assemble` gives the text of record, and the audio comes from
`/lf-narrate` then `/lf-render`. The rest of this command is the **book** path.

```bash
python3 scripts/longform.py lint --strict
python3 scripts/longform.py assemble
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
