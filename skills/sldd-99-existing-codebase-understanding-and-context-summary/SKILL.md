---
name: sldd-99-existing-codebase-understanding-and-context-summary
description: Capture existing-codebase context for brownfield exploration and before Step 02.
metadata:
  step: "99"
  type: appendix
---

# Skill: Existing Codebase Understanding and Context Summary

## Objective

Capture and approve existing-codebase context for brownfield exploration and safe Step 02+ work.

## Gate + Resume Checks

- Required before Step 02 for existing codebases.
- May be run during Step 88 exploration when codebase understanding is needed to clarify scope, constraints, risks, or alternatives.
- Optional for greenfield projects.
- Do not mark Step 99 complete without explicit approval.
- If resuming later, re-evaluate the current codebase before relying on any previous Step 99 summary.
- Reuse a previous Step 99 only if it still reflects the current codebase and approved Step 01 scope; update or rerun it if stale, incomplete, or scoped to a rejected exploration direction.
- Reject inconsistent checklist states where Step 02+ is complete while Step 99 is required and incomplete.

## Draft Output

Create a draft with these required Step 99 headings:

- Repository Structure Overview
- Architecture Summary
- Conventions to Preserve
- Integration Points
- Risks and Unknowns
- Context to Carry Into Steps 02-06

Wait for approval.

## Approval Protocol

- Mark complete, save, or update `docs/specs/<feature-name>/SPEC.md` only after explicit approval.
- On rejection, requested changes, hold, or ambiguous approval, do not persist progress; clarify or wait.
- If writes are unavailable, stop and report the limitation.

## Save Flow (after approval)

1. Ask whether to persist `docs/specs/<feature-name>/99-existing-codebase-understanding.md`; saving this snapshot is optional.
2. If persistence is approved, save `docs/specs/<feature-name>/99-existing-codebase-understanding.md`.
3. Mark Step 99 complete in journal-only `docs/specs/<feature-name>/SPEC.md` with the saved link or a not-saved note requiring re-run on resume.
4. Ask whether to continue to the next step or hold.

## Response Format

1. Gate and resume check result
2. Draft summary with required Step 99 headings
3. Persistence choice (save artifact vs. approved-not-saved journal note)
4. Approval request and continue/hold prompt
