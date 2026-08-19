---
name: create-workspace
description: Create a new book project workspace from the Claude-Book-Workspace-Template repository, or scaffold one locally. Use when starting a new book, or when the user asks to set up a book project.
---

# Creating a book workspace

A book project lives in its own repository, instantiated from the template. It is
separate from this plugin because the two run on different clocks: the plugin is
replaced wholesale on `/plugin update`, and a book project lives for months and
diverges from the template forever.

## 1. Establish what is being made

Ask only what you cannot infer: a project name, and whether there is existing
material here to build from. Glob for `manuscript/`, `chapters/`, `*.md` before
asking — if the user is standing in a directory of notes, say so.

Do not run the intake interview here. That is the definition team's job and it
happens after the workspace exists.

## 2. Confirm before creating

Creating a repository is outward-facing. Show the exact command and state what
the repository will hold, so a `--public` choice is made knowingly:

```bash
gh repo create <name> --template danielrosehill/Claude-Book-Workspace-Template --private --clone
```

**Private by default.** A book in progress usually should be. Ask; do not infer
from the fact that another repository nearby is public.

`gh` handles the template instantiation race internally — no wait loop is needed.
The result is a squashed initial commit with no upstream link, so the project
never receives template changes afterwards. That is intended.

If `gh` is unavailable, copy `${CLAUDE_PLUGIN_ROOT}/template/` into the target
directory and `git init`. Say that the GitHub repository was not created.

## 3. Mark it

Write `.book-writing` at the workspace root:

```yaml
created: <YYYY-MM-DD>
template: danielrosehill/Claude-Book-Workspace-Template
template_version: 1.0.0
backing: github          # github | local
repo: <owner>/<name>
workspace_root: .
```

Every other skill finds the workspace by searching the current directory and then
upward for this file. Never assume the enclosing git repository is the workspace.

## 4. Make it this project's repository

- Replace the template's `README.md` with a status page for this book.
- Leave `CLAUDE.md` alone. It is the directive layer and it applies unchanged.
- Commit and push.

## 5. Then hand off

Report the path and say that the next step is recording the brief — `/book-brief`,
which records what the user wants without asking them anything.

Do not begin the intake yourself, and do not start proposing chapters.
