---
description: Record the user's brief for the work exactly as given, asking nothing
argument-hint: "[the brief, or a path to it]"
---

Record the brief. Content: $ARGUMENTS

Dispatch the `brief-recorder` subagent.

It asks no questions, interprets nothing, and tidies nothing. A vague brief is
recorded as a vague brief. Gaps are the interviewer's job, and the original
framing is evidence that becomes unrecoverable once paraphrased.

If the brief was dictated, disfluencies may be removed and nothing else.

Output is `spec/brief.md`. Then stop; `/lf-interview` is next.
