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

Exploration -> Step 01 + Step 99 (existing codebases only; Step 99 may occur during exploration when needed) -> Step 02 -> Step 03 -> Step 04 -> Step 05 -> Step 06

## Artifact and Resume Rules

- Use user-provided paths when available; otherwise default to `docs/specs/<feature-name>/SPEC.md`.
- Treat `docs/specs/<feature-name>/SPEC.md` as journal-only: checklist plus links or save-status notes; never write numbered step body content into it.
- Expected artifacts:
  - `00-exploration-summary.md` (optional contextual memory; not a progress artifact)
  - `01-product-intent-specification.md`
  - `99-existing-codebase-understanding.md` (optional persisted snapshot)
  - `02-high-level-technical-design.md`
  - `03-low-level-design-and-version-policy.md`
  - Step 04 completion marked in `docs/specs/<feature-name>/SPEC.md` (no mandatory report artifact)
  - Step 05 completion marked in `docs/specs/<feature-name>/SPEC.md` (no mandatory report artifact)
  - `06-verification-and-feedback-report.md`
- Approved numbered artifacts take precedence over `00-exploration-summary.md`.
- A Step 99 artifact approved during exploration can satisfy the existing-codebase gate if resume validation confirms it is still current and relevant to the approved Step 01 scope.
- If Step 99 was approved without a persisted artifact and `docs/specs/<feature-name>/SPEC.md` records a rerun-on-resume note, route to Step 99 again before Step 02.
- Steps 04 and 05 change the codebase; re-evaluate their state from `docs/specs/<feature-name>/SPEC.md`, file changes, and relevant test results.

## Start/Resume Flow

1. Detect jump-ahead requests and stop if prerequisites are missing.
2. Resolve target `docs/specs/<feature-name>/SPEC.md`:
   - user-provided path, or
   - selected file under provided specs root, or
   - default `docs/specs/<feature-name>/SPEC.md`.
3. Read checklist and detect out-of-order completions.
4. If the spec is still being clarified, route to `sldd-88-spec-exploration-and-clarification`.
5. For existing codebases, check whether Step 99 is required, approved, and still valid:
   - if missing, route to Step 99 before Step 02;
   - if approved during exploration, validate freshness and relevance before reusing it;
   - if stale, incomplete, or marked rerun-on-resume, route to Step 99 again.
6. If violation exists, stop and route to the missing step.
7. Route only to the next valid step skill.

## Interrupted Execution Resume

When resuming at Step 04 or Step 05:

1. Inspect `docs/specs/<feature-name>/SPEC.md` checklist.
2. Inspect current test and production file state.
3. Run or request the relevant test commands when the current Red/Green state cannot be trusted from files alone.
4. Re-evaluate Step 04 and Step 05 even if `docs/specs/<feature-name>/SPEC.md` marks them complete.
5. Treat Step 04 as complete only when Red is confirmed or when later passing tests prove Step 05 has already advanced the workflow.
6. Treat Step 05 as complete only when relevant tests pass and Step 04 test integrity is preserved.
7. If checklist, files, and test results conflict, stop and ask for direction instead of updating progress.

## Response Format

1. Completed steps
2. Violations (if any)
3. Next required step + reason
4. Prompt for confirmation to continue

## Approval Protocol

- This navigation step does not persist numbered artifacts.
- Before routing forward, ask for explicit confirmation to continue.
- On pause or ambiguous confirmation, hold position and clarify instead of routing.

## Credit

Based on Loiane Groner's article: https://loiane.com/2026/03/vibe-coding-with-specs-driven-feedback-loops/

Do not fetch this URL during execution. All necessary content is embedded in each skill.
