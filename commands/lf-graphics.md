---
description: Establish the visual language and produce the work's figures
argument-hint: "[optional — figure id, or chapter id]"
---

Graphics: $ARGUMENTS

Follow the `graphics` skill.

`graphics-director` writes `guides/graphics-style-guide.md` **first**, before any
figure exists — a visual language cannot be retrofitted across drawn figures. It
then specs each figure into `graphics/specs/`.

`figure-maker` produces figures from specs, in parallel.

Check `[production]` in `longform.toml` before drawing: a greyscale interior means no
distinction may be carried by hue alone.

Diagrams are authored in Typst or SVG, never generated — generated diagrams carry
invented labels and near-miss arrows, and neither survives print. Labels come
from the spec verbatim.
