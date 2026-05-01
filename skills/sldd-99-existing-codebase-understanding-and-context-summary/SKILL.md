---
name: sldd-99-existing-codebase-understanding-and-context-summary
description: Capture existing-codebase context before Step 02 in brownfield projects.
metadata:
  step: "99"
  type: appendix
---

# Skill: Existing Codebase Understanding and Context Summary

Use `sldd-88-shared-templates-and-protocols` for shared gates, save decision, and templates.

## Objective

Capture and approve existing-codebase context for safe Step 02+ work.

## Gate + Resume Checks

- Required before Step 02 for existing codebases.
- Optional for greenfield projects.
- Do not mark Step 99 complete without explicit approval.
- If resuming later, re-evaluate the current codebase before relying on any previous Step 99 summary.
- Reject inconsistent checklist states where Step 02+ is complete while Step 99 is required and incomplete.

## Draft Output

Create a draft with required Step 99 headings from Step 88 "Compact Step Template Contracts".
Wait for approval.

## Approval Protocol

- Use `sldd-88-approval-helper` messaging.
- Do not mark complete or save/update without explicit approval.

## Save Flow (after approval)

1. Ask whether to persist `docs/specs/<feature-name>/99-existing-codebase-understanding.md`; saving this snapshot is optional.
2. If persistence is approved, save `docs/specs/<feature-name>/99-existing-codebase-understanding.md`.
3. Update `SPEC.md` Step 99 `[x]` with either the saved link or a not-saved note requiring re-run on resume.
4. Verify `SPEC.md` remains journal-only; do not write Step 99 body content into `SPEC.md`.
5. Use `sldd-88-approval-helper` completion prompt.

Apply Step 88 "Shared Save Decision".

## Response Format

1. Gate and resume check result
2. Draft summary with required Step 99 headings
3. Persistence choice (save artifact vs. approved-not-saved journal note)
4. Approval request and continue/hold prompt
