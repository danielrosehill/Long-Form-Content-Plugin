---
description: Start a new book project — create the workspace repository from the template
argument-hint: "[optional — project name, or what the book is about]"
---

Set up a new book project. Scope: $ARGUMENTS

Use the `create-workspace` skill.

In short: establish a project name, glob for existing material before asking
about it, then **confirm the exact `gh repo create` command and the visibility
before running it**. Private by default. Write the `.book-writing` marker, replace
the template README with a status page for this book, commit and push.

Then stop and hand off to `/book-brief`. Do not start the intake, and do not
propose chapters.
