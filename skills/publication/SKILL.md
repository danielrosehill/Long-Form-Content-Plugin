---
name: publication
description: The production stage, branched by [output] type. Book, assemble, typeset the body and hand off to print geometry. Report, assemble and export a research PDF via pandoc and typst. Screenplay, assemble Fountain and export a PDF. Audiobook, hand to audiobook-production. Use as the final stage, after review.
---

# Publication

Read `[output] type` in `longform.toml` first. Everything before this stage was
the same for every type; this is where they part.

| Type | Go to |
| --- | --- |
| `book` | the rest of this skill |
| `report` | [Report](#report) below |
| `screenplay` | [Screenplay](#screenplay) below |
| `audiobook` | the `audiobook-production` skill |

## Book

Turning a directory of chapters into something a print-on-demand service accepts.

### Two jobs, and this stage owns one of them

| Job | Owner |
| --- | --- |
| Manuscript — concatenation, body typesetting, profile conformity | here |
| Print geometry — trim, gutter, spine, cover wrap, pre-flight | [`kdp-publishing`](https://github.com/danielrosehill/KDP-Publishing-Plugin) |

The split is not administrative. **A cover cannot be built until the interior is
final**, because spine width is page count multiplied by paper caliper. A cover
built from an estimated page count produces a spine whose type sits off-centre,
and nothing on screen reports it — it is discovered when the proof copy arrives.

So geometry is handed off, last, to a tool that refuses to accept a page count
and measures the built PDF instead. Do not reimplement any of it here.

### Sequence

```bash
python3 scripts/longform.py lint --strict     # warnings become errors
python3 scripts/longform.py assemble          # dist/manuscript.md + dist/manuscript.json
```

`--strict` first, and it is not optional. An unresolved `[VERIFY:]` marker or a
figure without a spec is a hard failure at this point.

`assemble` writes two files: the concatenated manuscript in manifest order with
part dividers, and a JSON sidecar carrying title, author, snapshot date, profile,
handoff target, word count and per-chapter status. Undrafted chapters appear as
comments rather than being silently omitted — "which chapters were actually in
this build" is the first question asked when a proof looks wrong.

### Typesetting profiles

`typeset/profiles/*.toml` describe how the text is set — measure, families,
sizes, leading. They do not describe trim, gutter, spine or bleed.

**One value leaks upward into authoring: the measure.** It fixes the maximum
monospace line length that will not wrap in print, and that cap belongs in the
style guide. It is a measurement, not a convention. A book authored against Crown
Quarto's 5.62in measure and moved to KDP 6x9 will wrap its listings, and the
symptom appears on a proof rather than in a build. Re-derive the cap whenever
trim or monospace size changes.

### Channel differences worth knowing

- Lulu offers Crown Quarto (7.44 × 9.68in); KDP does not. KDP's 7.5 × 9.25in is
  not offered by Lulu. Targeting both means a profile per channel and two
  different page counts.
- Colour interior changes cost per page substantially — a definition-stage
  decision, not one to discover at upload.

### Handoff

Read `[production] handoff` in `longform.toml`. Default `kdp-publishing`. Pass it
`dist/manuscript.md` and `dist/manuscript.json`, and let it own everything from
trim geometry onward.

Set `status = "production"`.

## Report

A long-form research report: numbered sections, citations, a PDF.

```bash
python3 scripts/longform.py lint --strict
python3 scripts/longform.py assemble     # dist/report.md with a pandoc title block
python3 scripts/longform.py export       # dist/report.pdf: pandoc + typst, TOC, numbered sections
```

- `research/references.bib`, if it exists, is used with `--citeproc`. Otherwise
  citations are whatever the style guide fixed (footnotes or inline).
- The executive summary is written **after** the sections, by one agent reading
  the section briefs' Argument lines plus each section's opening paragraph. It
  must not read every section in full. It goes in as the first unit (`ch00`).
- Override the PDF step with `[output] export_cmd` (`{input}`, `{output}`) for a
  house template.
- Open the PDF and look at it. A clean exit does not mean the figures resolved.

## Screenplay

Units are Fountain files. A unit is a *sequence*: a run of scenes one writer
owns, sized so a writer can hold it (roughly five to fifteen pages).

```bash
python3 scripts/longform.py lint --strict
python3 scripts/longform.py assemble     # dist/screenplay.fountain with a title page
python3 scripts/longform.py export       # PDF via afterwriting or screenplain, or export_cmd
```

`dist/screenplay.fountain` opens directly in Highland, Fade In, Slugline and
WriterDuet, which is often the real handoff. Page count is the runtime estimate
(about one page a minute). Check it against the spec's target, after export,
from the PDF.

Set `status = "production"` when done, whichever type.
