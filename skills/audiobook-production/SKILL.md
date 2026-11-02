---
name: audiobook-production
description: Take a reviewed audiobook manuscript to a finished, chaptered audiobook. Narration adapters produce spoken scripts in parallel, script-lint and a spoken-layer seam pass check them, each chapter is rendered through the configured TTS command (resumably), and the chapters are joined with chapter marks, tags, cover and loudness normalisation. Use as the production stage when [output] type = "audiobook".
---

# Audiobook production

The audiobook equivalent of typesetting. Everything before this (definition,
planning, drafting, review) is the same as for a book. This stage turns
reviewed chapters into `dist/audiobook.m4b`.

```
manuscript/  →  narration-adapter ×n  →  audio/script/  →  script-lint + seams --layer script
             →  render (TTS, per chapter, resumable)  →  audio/chapters/
             →  audio-assemble  →  dist/audiobook.m4b + audiobook.json
```

## 0. Settle `[audio]` once

In `longform.toml`: `format` (plain or ssml, whatever the engine accepts),
`voice`, `narrator`, `render_cmd`, `cover`, optional `intro`/`outro`.

`render_cmd` is the only engine-specific piece: one shell command that turns one
script file into one audio file, with `{input} {output} {id} {title} {voice}`.
The workspace never knows which engine it is, so the engine can change without
touching anything else. Examples:

```toml
render_cmd = "edge-tts --voice {voice} -f {input} --write-media {output}"
render_cmd = "with-secrets python3 ~/tools/my_tts.py --voice {voice} {input} {output}"
```

An engine that chunks internally (most long-text TTS does) belongs inside that
command. The pipeline's unit is the chapter.

## 1. Spoken scripts, in parallel

Run only on chapters that are `reviewed` or `final`. Adapting text that is still
changing means adapting it twice.

Dispatch one `narration-adapter` per chapter in a single message. They write
disjoint files, but they all append to `guides/pronunciation.md`. To keep those
writes from colliding, **seed the lexicon first**. Before dispatching, grep the
manuscript for acronyms and unusual names:

```bash
grep -ohE '\b[A-Z]{2,}s?\b' manuscript/*.md | sort | uniq -c | sort -rn | head -40
```

Settle those rows yourself, so adapters mostly read the lexicon instead of
writing to it.

## 2. Check the spoken layer

```bash
python3 scripts/longform.py script-lint            # digits, symbols, URLs, markdown, brackets,
                                                   # visual refs, unknown acronyms, stale scripts
python3 scripts/longform.py seams --layer script   # then one seam-reviewer per *.script.md
```

The spoken seam pass is not a repeat of the manuscript one. Adaptation adds the
chapter announcements and changes the openings and closings, and a listener
hears a doubled sign-off or a "next chapter" tease that a reader skims past.

`script-lint --strict` must be clean, or every remaining warning explained,
before rendering. Rendering is the step that costs money.

## 3. Listen to one chapter first

```bash
python3 scripts/longform.py render --only ch01
```

Have the user listen before rendering the rest. The voice, the pace and the
pronunciation of the first few lexicon entries are cheap to change now, and
expensive after ten chapters.

## 4. Render the rest

```bash
python3 scripts/longform.py render --keep-going
```

Run it in the background. Chapters render one at a time. A finished chapter is
never redone unless forced (`--force --only chNN`), and a failed one leaves no
partial file, so re-running resumes where it stopped. `render` warns when a
chapter's audio is older than its script.

Cost scales with words. Estimate from `status` (it prints spoken hours at
`words_per_minute`) and the engine's price before a long render, and follow the
user's spend rules.

## 5. Assemble and tag

```bash
python3 scripts/longform.py audio-assemble
```

This step:

- converts every chapter to one PCM format
- joins the chapters with `gap_seconds` of silence and the optional intro and outro
- normalises loudness to `loudness_lufs`, with a true peak of -3 dB
- encodes AAC into an `.m4b`
- embeds chapter marks (`chapter_title_format`), title, author, narrator, genre, year and cover art

It writes `dist/audiobook.json` (chapter start and end times, duration, md5,
voice, render command) and `dist/chapters.ffmeta`.

Check the result with `ffprobe -show_chapters dist/audiobook.m4b` rather than
trusting the exit code. Then listen to every seam point at least briefly, because
that is where problems in assembly show.

## Companion PDF

Tables, links, figures and reference data the ear cannot carry go in a short
companion document, and the narration points to it once. Build it as a `report`
from the same research (a second workspace, or `pandoc` over a hand-written
`dist/companion.md`).

## Delivery

The plugin stops at `dist/`. Where the file goes (a Drive folder, a podcast feed,
ACX or Findaway) is the user's call and their own tooling. Retail channels have
their own audio specs (ACX: -23 to -18 dB RMS, -3 dB peak, per-chapter files).
Set `loudness_lufs` to match and keep `audio/chapters/` for channels that want
one file per chapter.
