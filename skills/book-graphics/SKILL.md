---
name: book-graphics
description: Produce the book's figures — establish the graphics style guide, spec each figure, and generate them. Use after chapters are drafted, in parallel with review.
---

# Graphics

For technical and instructional books, figures are content. This stage exists so
that thirty figures made in thirty separate invocations look like one book's
figures — the prose-voice problem in another medium, with the same solution.

```
graphics-director  →  figure-maker (per figure, parallel)
guide + specs         sources + assets
```

## Order

1. **`graphics-director`** writes `guides/graphics-style-guide.md` first, before
   any figure exists. Retrofitting a visual language across drawn figures does
   not work.
2. It then reads the drafted chapters and writes one spec per figure into
   `graphics/specs/`, adding paths to each chapter's `figures` list.
3. **`figure-maker`** produces figures from specs. Parallelises freely — each
   reads its own spec and the style guide, and nothing else.

## Decide greyscale before drawing

Read `[production]` in `book.toml`. If the interior prints greyscale, no
distinction may be carried by hue alone. This cannot be retrofitted across a set
of finished figures, and colour interiors change cost per page substantially.

## A figure earns its place

By showing a mechanism prose would take a page to describe and still leave
ambiguous. If prose does it in two sentences, prose wins. Decorative images and
"visual interest" are out.

## Diagrams are authored, not generated

Image models produce diagrams with invented labels, near-miss arrows and
plausible structure that is subtly wrong, and none of it survives print scrutiny.
Diagrams are Typst or SVG source, committed, so a wrong label is fixable.

Generated imagery is fine for illustration that carries no information. Each spec
says which kind it is.

## Labels are verbatim

Figure-makers invent plausible labels when they are not given exact ones, and
invented labels print. Every string appearing in a figure is written in its spec.

## Checking

`python3 scripts/book.py lint` fails on a `::: figure <id>` directive with no
spec at `graphics/specs/<id>.md`.

It cannot check that the figure shows what the spec describes. Look at each
figure at final printed size — a diagram that is clear on screen and illegible at
3.5 inches wide has failed.
