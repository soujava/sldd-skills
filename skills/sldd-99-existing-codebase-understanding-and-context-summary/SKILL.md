---
name: sldd-99-existing-codebase-understanding-and-context-summary
description: Read and summarize an existing codebase before any design or implementation work begins. Use as a prerequisite when the project is not greenfield.
metadata:
  step: "99"
  type: appendix
---

# Skill: Existing Codebase Understanding and Context Summary

## Project Settings

At the start of this step, before any other action:

1. **Read `AGENTS.md`** at the project root.
2. **Look for the `## SLDD` section** and extract:
   - `language` — use this for all conversation output and generated file content.
   - `specs-dir` — use this as the root directory for all spec file paths.
3. **Resolve language with this precedence:**
   - If the user explicitly requests a language in the current interaction, use it immediately.
   - Otherwise, use `language` from `AGENTS.md`.
   - If no language is configured, ask once, use the answer, and persist it in `AGENTS.md`.
4. **If the `## SLDD` section is missing:** ask the user to run `sldd-00` first to configure project settings, or ask them directly (in the resolved language) for preferred language and specs directory.
5. **Apply these settings throughout this step** — all responses, drafts, questions, and saved files must use the resolved language and specs directory.

### Language Compliance Check (mandatory before every reply)

Before sending any user-facing message, validate language compliance:
- The full response (including final review/approval prompts) must be in the resolved language.
- All the pre-defined replies  must be translated to the resolved language.
- If this skill contains example text in another language, translate the meaning; do not copy that text literally.
- If any sentence is not in the resolved language, rewrite the response before sending.

---

This is an optional prerequisite step. For greenfield projects, skip this and proceed directly to sldd-01.

**Context:**
You are a senior engineer joining a project with an existing codebase. Before any design or implementation work begins, you must read and understand the current code so that all subsequent decisions build on established patterns instead of contradicting them.

Repository or module scope: <provide path or module names>

SPEC.md (optional): <provide path to an existing SPEC.md to load prior context, or leave blank to start fresh>

**SPEC.md resume behavior:**
If a SPEC.md path is provided:
1. Read the file and check the Progress checklist to identify which steps are already complete.
2. Extract Step 01 (Product Intent Specification) as prior context if present.
3. Announce in the resolved language that SLDD is resuming, list completed steps, and indicate continuation with Step 99.
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
