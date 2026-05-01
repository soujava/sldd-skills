---
name: sldd-00-process-overview-and-navigation-guide
description: Start/resume SLDD, validate checklist consistency, and route to exploration or the next valid step.
metadata:
  step: "00"
  type: navigation
---

# Skill: SLDD Process Overview and Navigation Guide

## Objective

Determine current state, block invalid jumps, and route to the correct next step.

## Gate Order

Exploration -> Step 01 -> Step 99 (existing codebases only) -> Step 02 -> Step 03 -> Step 04 -> Step 05 -> Step 06

## Artifact and Resume Rules

- Use user-provided paths when available; otherwise default to `docs/specs/<feature-name>/SPEC.md`.
- Treat `SPEC.md` as journal-only: progress checklist plus links or save-status notes.
- Do not write numbered step body content into `SPEC.md`.
- Expected artifacts:
  - `00-exploration-summary.md` (optional contextual memory; not a progress artifact)
  - `01-product-intent-specification.md`
  - `99-existing-codebase-understanding.md` (optional persisted snapshot)
  - `02-high-level-technical-design.md`
  - `03-low-level-design-and-version-policy.md`
  - `04-tests-first-report.md`
  - `05-minimal-implementation-report.md`
  - `06-verification-and-feedback-report.md`
- Approved numbered artifacts take precedence over `00-exploration-summary.md`.

## Start/Resume Flow

1. Detect jump-ahead requests and stop if prerequisites are missing.
2. Resolve target `SPEC.md`:
   - user-provided path, or
   - selected file under provided specs root, or
   - default `docs/specs/<feature-name>/SPEC.md`.
3. Read checklist and detect out-of-order completions.
4. If the spec is still being clarified, route to `sldd-88-spec-exploration-and-clarification`.
5. If violation exists, stop and route to the missing step.
6. Route only to the next valid step skill.

## Response Format

1. Completed steps
2. Violations (if any)
3. Next required step + reason
4. Prompt for confirmation to continue

## Approval Protocol

- This navigation step does not persist numbered artifacts.
- Before routing forward, ask for explicit confirmation to continue.
- If the user asks to pause, hold position and wait for instructions.
- If confirmation intent is ambiguous, ask for clarification instead of routing.

## Credit

Based on Loiane Groner's article: https://loiane.com/2026/03/vibe-coding-with-specs-driven-feedback-loops/

Do not fetch this URL during execution. All necessary content is embedded in each skill.
