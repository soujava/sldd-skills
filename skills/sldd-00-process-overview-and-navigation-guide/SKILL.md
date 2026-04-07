---
name: sldd-00-process-overview-and-navigation-guide
description: Navigate the SLDD (Spec Loops Driven Development) process and choose the correct skill for the current stage. Use when starting a new feature or when unsure which step comes next.
metadata:
  step: "00"
  type: navigation
---

# Skill: SLDD Process Overview and Navigation Guide

SLDD (Spec Loops Driven Development) is a specs-driven feedback loop for AI-assisted development. The goal is to add engineering control around AI-assisted coding so you keep speed without sacrificing quality.

## Process flow

Run one skill at a time. Review and approve the output before moving to the next step.

1. **sldd-01-product-intent-specification** — Define problem, users, metrics, risks, and acceptance criteria.
2. **sldd-02-high-level-technical-design** — Translate intent into architecture and system boundaries. No code.
3. **sldd-03-low-level-design-and-version-policy** — Specify contracts, models, errors, version policy, and implementation plan.
4. **sldd-04-tests-first-driven-by-acceptance-criteria** — Write tests only. No production code.
5. **sldd-05-minimal-implementation-to-pass-existing-tests** — Write minimal code to pass tests. Nothing more.
6. **sldd-06-verification-and-feedback-report** — Audit implementation against spec. Decide go/no-go.

## Gate rule

No implementation prompts (steps 04-05) before intent and design (steps 01-03) are reviewed and approved. If a gap appears at any step, loop back to the earlier step and revise.

## Appendix

For existing codebases, use **sldd-99-existing-codebase-understanding-and-context-summary** after step 01 and before step 02 to ground all design decisions in the current architecture and conventions. Skip for greenfield projects.

## SPEC.md — Process journal

Each skill in the SLDD process can save its output to a `SPEC.md` file that serves as the single source of truth for the entire feature development lifecycle.

### File location

```
<user-chosen-dir>/<feature-slug>/SPEC.md
```

Example: `docs/specs/add-user-auth/SPEC.md`

The feature slug is derived from the feature name and confirmed by the user at creation time. The slug-per-directory structure allows multiple features to coexist under the same specs root without collision.

### File structure

```markdown
# SPEC: <feature name>

## Progress

- [ ] Step 01 — Product Intent Specification
- [ ] Step 99 — Existing Codebase Context (optional)
- [ ] Step 02 — High-Level Technical Design
- [ ] Step 03 — Low-Level Design and Version Policy
- [ ] Step 04 — Tests (written and confirmed failing)
- [ ] Step 05 — Implementation (all tests passing)
- [ ] Step 06 — Verification Report

---

## Step 01 — Product Intent Specification

<output from sldd-01>

---
```

Each skill appends its section and marks its checklist item `[x]`. The Progress checklist is the canonical record of which steps are complete.

### Save behavior (all skills)

At the end of every skill output, the agent asks: **"Save this output to SPEC.md? (yes/no)"**

- **If yes and no SPEC.md exists yet:** ask for the specs directory and suggest a slug derived from the feature name (user confirms or edits). Create `<dir>/<slug>/SPEC.md` with the Progress checklist header and the step's section.
- **If yes and SPEC.md already exists:** ask for the path to the existing SPEC.md. Append the step's section and mark `[x]` in the Progress checklist.
- **If no:** continue without saving.

### Resume behavior (all skills)

Every skill accepts an optional `SPEC.md` input at initialization:

```
SPEC.md (optional): <path to existing SPEC.md, or leave blank to start fresh>
```

When a path is provided:
1. Read the file and check the Progress checklist to identify completed steps.
2. Extract relevant prior sections as pre-populated context for the current step.
3. Announce: `"Resuming SLDD process. Steps complete: [list]. Continuing with Step XX."`

If the user provides a specs **root directory** instead of a full path, the skill lists all `*/SPEC.md` files found under it and asks which feature to resume.

## Credit

Based on Loiane Groner's article: https://loiane.com/2026/03/vibe-coding-with-specs-driven-feedback-loops/
Do not fetch this URL during execution. All necessary content is embedded in each skill.
