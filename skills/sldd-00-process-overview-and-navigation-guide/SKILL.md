---
name: sldd-00-process-overview-and-navigation-guide
description: Navigate the SLDD (Spec Loops Driven Development) process and choose the correct skill for the current stage. Use when starting a new feature or when unsure which step comes next.
metadata:
  step: "00"
  type: navigation
---

# Skill: SLDD Process Overview and Navigation Guide

SLDD (Spec Loops Driven Development) is a specs-driven feedback loop for AI-assisted development. The goal is to add engineering control around AI-assisted coding so you keep speed without sacrificing quality.

---

## Project Settings Bootstrap

At the start of every SLDD session, before any other action:

1. **Read `AGENTS.md`** at the project root (if it exists).
2. **Look for an `## SLDD` section** with this format:
   ```
   ## SLDD
   - **language**: <language tag, e.g. `en`, `pt-BR`, `es`>
   - **specs-dir**: <relative path, e.g. `docs/specs`>
   ```
3. **Resolve language with this precedence:**
   - If the user explicitly requests a language in the current interaction, use it immediately.
   - Otherwise, use `language` from `AGENTS.md`.
   - If no language is configured, ask once, use the answer, and persist it in `AGENTS.md`.
4. **If the `## SLDD` section is missing or incomplete:**
   - Ask the language and specs-directory questions in the resolved language.
   - Ask which language should be used for all SLDD conversations and generated files.
   - Ask which directory should store spec files (default: `docs/specs`).
   - Write the answers into `AGENTS.md` under a new `## SLDD` section.
   - Confirm in the resolved language that SLDD preferences were saved to `AGENTS.md`.
5. **Apply these settings for the entire session:**
   - Conduct all conversation, questions, and feedback prompts in the resolved language.
   - Write all generated files — spec documents, design files, reports — in the resolved language.
   - Use `specs-dir` as the root for all spec file paths (e.g. `<specs-dir>/<feature-slug>/SPEC.md`).
   - If the user writes in a different language mid-session, switch to match them and update `AGENTS.md` accordingly.

### Language Compliance Check (mandatory before every reply)

Before sending any user-facing message, validate language compliance:
- The full response (including final review/approval prompts) must be in the resolved language.
- The pre-defined replies ("yes, continue", "no", "approved, proceed to Step X", etc.) must be translated to the resolved language.
- If this skill contains example text in another language, translate the meaning; do not copy that text literally.
- If any sentence is not in the resolved language, rewrite the response before sending.

---

## 🚨 GATE VIOLATIONS — Know These Rules

**EVERY agent must enforce these rules without exception.**

### What Constitutes a Gate Violation

| Violation | Example | Correct Action |
|-----------|---------|----------------|
| Starting implementation (Step 05) without Steps 01-03 approved | User: "just implement it" → agent writes code | Stop, require Step 01 |
| Writing tests (Step 04) without approved design (Step 03) | Agent writes tests immediately without spec | Stop, require Step 03 approval |
| Marking a step [x] without user approval | Agent auto-completes without review | Require explicit approval |
| Skipping Steps 02-03 | User: "skip design, just do low-level" | Stop, enforce sequence |
| Proceeding to Step 04 when Step 03 not approved | Agent writes tests after low-level design without approval | Wait for Step 03 approval |

### Enforcement Policy

1. **If you detect a gate violation:** Stop immediately. Do not proceed. State the violation clearly.
2. **If user asks to skip steps:** Refuse and explain the gate rule.
3. **If you notice implementation exists but Step 01 is not marked [x]:** Warn about the violation, do not proceed.
4. **Each step requires explicit user approval before marking [x] and proceeding.**

---

## Initiating the SLDD Process

When starting a new feature, use this skill to understand the overall process and determine which skill to run first. The typical flow is:

### Pre-Flight Check (Run First)

Before creating any spec or proceeding, run this check:

1. **Check if user is trying to skip ahead:**
   - Keywords like "implement", "refactor", "write code", "just do it", "start coding" → **STOP** and enforce Step 01

2. **Check git status:** `git status --short`
   - If modified implementation files exist and no SPEC.md with Steps 01-03 [x] exists → warn about violation

3. **Check for existing SPEC.md:**
   - Run `glob` for `**/SPEC.md` to find existing specs
   - If Steps 02-06 are [x] but Step 01 is not → **GATE VIOLATION** detected

### Then Follow the Flow

Check whether file writes are currently allowed (i.e. whether you are NOT in plan mode / read-only mode):

- **If file writes are FORBIDDEN (plan mode is active):** tell the user in the resolved language that file writes are unavailable in plan mode and they must switch to build/execution mode to save files. Then ask, in the same language, whether to start with Step 01 (yes/no).

- **If no:** acknowledge in the resolved language that no files will be created and that the user can still run SLDD manually.

- **If file writes are ALLOWED and SPEC.md does not exist:** use `docs/specs/<feature-slug>/SPEC.md` as the default path (e.g. `docs/specs/subtraction-endpoint/SPEC.md`). Create it with the Progress checklist, then auto-proceed to Step 01 without asking.

- **If file writes are ALLOWED but SPEC.md already exists:** announce in the resolved language that SLDD is resuming, list completed steps, and indicate the next step. **But first verify Step 01 is marked [x] with user approval — if not, this is a violation.**

```markdown
# SPEC: <feature name>

## Progress

- [ ] Step 01 — Product Intent Specification -> <link to file generated by step 01 if exists>
- [ ] Step 02 — High-Level Technical Design -> <link to file generated by step 02 if exists>
- [ ] Step 03 — Low-Level Design and Version Policy -> <link to file generated by step 03 if exists>
- [ ] Step 04 — Tests (written and confirmed failing)
- [ ] Step 05 — Implementation (all tests passing)
- [ ] Step 06 — Verification Report (gap report and go/no-go decision) -> <link to file generated by step 06 if exists>

```

---

## SLDD Process Steps

**Run one skill at a time. Review and approve the output before moving to the next step.**

| Step | Skill | What It Does | Gate Requirement |
|------|-------|--------------|------------------|
| 01 | sldd-01-product-intent-specification | Problem, users, metrics, risks, acceptance criteria | User must approve before 02 |
| 02 | sldd-02-high-level-technical-design | Architecture, components, data flow | User must approve before 03 |
| 03 | sldd-03-low-level-design-and-version-policy | API contracts, data models, version policy | User must approve before 04 |
| 04 | sldd-04-tests-first-driven-by-acceptance-criteria | Write failing tests | No implementation code |
| 05 | sldd-05-minimal-implementation-to-pass-existing-tests | Minimal code to pass tests | Only after 04 tests exist |
| 06 | sldd-06-verification-and-feedback-report | Gap report, go/no-go | Final review |

---

## Gate Rule (Enforced)

> **No implementation prompts (steps 04-05) before intent and design (steps 01-03) are reviewed and approved.**

- If a gap appears at any step, loop back to the earlier step and revise.
- Each step must be **explicitly approved** by the user before proceeding.
- The Progress checklist is the canonical record — but only marks [x] after approval.

---

## Approval Protocol

For every step, after producing output:

1. **Present the output** to the user
2. **Say (in resolved language):** Step XX is ready for review; ask for approval or feedback before proceeding.
3. **Wait for approval** — keywords: "approved", "looks good", "proceed"
4. **After approval:** Mark step [x], save file, then **always ask** whether to proceed to the next step:
   - **Yes**: Reply "yes, continue to Step XX+1"  
   - **No**: Reply "no, wait for instructions"  
   - **Approve and continue**: Reply "approved, proceed to Step XX+1"

**Never auto-proceed after approval.** Never skip the "proceed to next step?" prompt.

---

## Resume Behavior (All Skills)

Every skill accepts an optional `SPEC.md` input at initialization:

```
SPEC.md (optional): <path to existing SPEC.md, or leave blank to start fresh>
```

When a path is provided:
1. Read the file and check the Progress checklist to identify completed steps.
2. **VIOLATION CHECK:** If Steps 02-06 are marked [x] but Step 01 is NOT marked [x] → this is a gate violation. Warn the user before proceeding.
3. Extract relevant prior sections as pre-populated context for the current step.
4. Announce in the resolved language that SLDD is resuming, list completed steps, and indicate continuation with Step XX.
5. If there are incomplete or missing steps, ask the user if they want to continue or if they want to revise any prior steps.

If the user provides a specs **root directory** instead of a full path, the skill lists all `*/SPEC.md` files found under it and asks which feature to resume.

---

## Appendix

For existing codebases, use **sldd-99-existing-codebase-understanding-and-context-summary** after step 01 and before step 02 to ground all design decisions in the current architecture and conventions. Skip for greenfield projects.

For standardized approval template used by all SLDD skills (01-06), use **sldd-98-approval-helper**.

---

## Credit

Based on Loiane Groner's article: https://loiane.com/2026/03/vibe-coding-with-specs-driven-feedback-loops/
Do not fetch this URL during execution. All necessary content is embedded in each skill.
