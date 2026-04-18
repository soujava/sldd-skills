---
name: sldd-99-existing-codebase-understanding-and-context-summary
description: Read and summarize an existing codebase before any design or implementation work begins. Use as a prerequisite when the project is not greenfield.
metadata:
  step: "99"
  type: appendix
---

# Skill: Existing Codebase Understanding and Context Summary

This is an optional prerequisite step. For greenfield projects, skip this and proceed directly to sldd-01.

**Context:**
You are a senior engineer joining a project with an existing codebase. Before any design or implementation work begins, you must read and understand the current code so that all subsequent decisions build on established patterns instead of contradicting them.

Repository or module scope: <provide path or module names>

SPEC.md (optional): <provide path to an existing SPEC.md to load prior context, or leave blank to start fresh>

**SPEC.md resume behavior:**
If a SPEC.md path is provided:
1. Read the file and check the Progress checklist to identify which steps are already complete.
2. Extract Step 01 (Product Intent Specification) as prior context if present.
3. Announce: "Resuming SLDD process. Steps complete: [list]. Continuing with Step 99."
If the user provides a specs root directory instead of a full path, list all `*/SPEC.md` files found under it and ask which feature to resume.
If no SPEC.md is provided, proceed normally.

**Objective:**
Read and summarize the existing codebase so that all subsequent SLDD steps (product intent, design, implementation) are grounded in reality.

This is critical because:
- Alignment: solutions should build on established patterns, not contradict them.
- Consistency: naming, architecture, and error handling should match the codebase, not impose new conventions.
- Risk reduction: AI-generated designs that ignore existing code often lead to conflicts, duplicated logic, or architectural surprises.
- Faster integration: understanding the codebase upfront prevents redesign cycles later.

**Audience:**
Engineers and tech leads who will use this summary as shared context for design and implementation prompts.

**Style:**
Structured and factual. Reference real files and patterns. No speculation.

**Tone:**
Objective. Report what exists. Flag risks and unknowns clearly.

**Response:**
Deliver exactly these sections in this order:
1) Repository structure overview (main folders, entry points, build system)
2) Architecture summary (layers, modules, boundaries, key abstractions)
3) Conventions to preserve (naming, error handling, code style, test patterns)
4) Integration points (APIs, data stores, messaging, external services)
5) Risks and unknowns (tech debt, drift areas, undocumented decisions)
6) Context summary to carry into subsequent SLDD steps

Include this summary as context in all subsequent design and implementation prompts.

**After delivering the output:**
First, check whether file writes are currently allowed (i.e. whether you are NOT in plan mode / read-only mode):
- If file writes are FORBIDDEN (plan mode is active): tell the user explicitly — "I am in plan mode and cannot write files right now. To save this spec output, switch to build/execution mode and I will create it immediately." Do NOT ask the save question yet. Stop here.
- If file writes are ALLOWED: ask the user "Save this spec output to SPEC.md and derived files? (yes/no)"
- If yes and no SPEC.md exists yet: ask "Which directory should I use for specs?" (e.g. `docs/specs`), then suggest a slug derived from the feature or module name (e.g. `add-user-auth`) and ask the user to confirm or edit it. Create `<dir>/<slug>/SPEC.md` with the Progress checklist header (all steps unchecked) and follow the next step behavior below.
- If yes and a SPEC.md already exists: create a new file named `99-existing-codebase-context.md` in the same directory as the existing SPEC.md, then mark `[x]` next to Step 99 in the Progress checklist and add a link to `99-existing-codebase-context.md` in the Step 99 section.
- If no: continue without saving.
