---
name: sldd-99-existing-codebase-understanding-and-context-summary
description: Capture existing-codebase context before Step 02 in brownfield projects.
metadata:
  step: "99"
  type: appendix
---

# Skill: Existing Codebase Understanding and Context Summary

## Objective

Capture and approve existing-codebase context for safe Step 02+ work.

## Gate + Resume Checks

- Required before Step 02 for existing codebases.
- Optional for greenfield projects.
- Do not mark Step 99 complete without explicit approval.
- If resuming later, re-evaluate the current codebase before relying on any previous Step 99 summary.
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

- Ask for explicit approval before marking Step 99 complete, saving an artifact, or updating `SPEC.md`.
- Do not mark complete or save/update without explicit approval.
- If approval is rejected, requested changes are given, or the user asks to hold, leave progress unchanged and wait.
- If approval intent is ambiguous, ask for clarification instead of saving or updating progress.
- If writes are unavailable, stop and report the limitation.

## Save Flow (after approval)

1. Ask whether to persist `docs/specs/<feature-name>/99-existing-codebase-understanding.md`; saving this snapshot is optional.
2. If persistence is approved, save `docs/specs/<feature-name>/99-existing-codebase-understanding.md`.
3. Update `SPEC.md` Step 99 `[x]` with either the saved link or a not-saved note requiring re-run on resume.
4. Verify `SPEC.md` remains journal-only; do not write Step 99 body content into `SPEC.md`.
5. Ask whether to continue to the next step or hold.

## Response Format

1. Gate and resume check result
2. Draft summary with required Step 99 headings
3. Persistence choice (save artifact vs. approved-not-saved journal note)
4. Approval request and continue/hold prompt
