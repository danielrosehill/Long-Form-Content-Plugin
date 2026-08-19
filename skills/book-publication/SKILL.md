---
name: book-publication
description: Assemble the drafted chapters into a manuscript, typeset the body to the chosen profile, and hand off to print geometry. Use as the final stage, after review and graphics.
---

# Publication

Turning a directory of chapters into something a print-on-demand service accepts.

## Two jobs, and this stage owns one of them

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

## Sequence

```bash
python3 scripts/book.py lint --strict     # warnings become errors
python3 scripts/book.py assemble          # dist/manuscript.md + dist/manuscript.json
```

`--strict` first, and it is not optional. An unresolved `[VERIFY:]` marker or a
figure without a spec is a hard failure at this point.

`assemble` writes two files: the concatenated manuscript in manifest order with
part dividers, and a JSON sidecar carrying title, author, snapshot date, profile,
handoff target, word count and per-chapter status. Undrafted chapters appear as
comments rather than being silently omitted — "which chapters were actually in
this build" is the first question asked when a proof looks wrong.

## Typesetting profiles

`typeset/profiles/*.toml` describe how the text is set — measure, families,
sizes, leading. They do not describe trim, gutter, spine or bleed.

**One value leaks upward into authoring: the measure.** It fixes the maximum
monospace line length that will not wrap in print, and that cap belongs in the
style guide. It is a measurement, not a convention. A book authored against Crown
Quarto's 5.62in measure and moved to KDP 6x9 will wrap its listings, and the
symptom appears on a proof rather than in a build. Re-derive the cap whenever
trim or monospace size changes.

## Channel differences worth knowing

- Lulu offers Crown Quarto (7.44 × 9.68in); KDP does not. KDP's 7.5 × 9.25in is
  not offered by Lulu. Targeting both means a profile per channel and two
  different page counts.
- Colour interior changes cost per page substantially — a definition-stage
  decision, not one to discover at upload.

## Handoff

Read `[production] handoff` in `book.toml`. Default `kdp-publishing`. Pass it
`dist/manuscript.md` and `dist/manuscript.json`, and let it own everything from
trim geometry onward.

Set `status = "production"`.
