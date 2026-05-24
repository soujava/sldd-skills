# Step 99: Existing Codebase Understanding and Context Summary

## Objective

Capture and approve existing-codebase context for brownfield exploration and safe Step 02+ work.

## Gate + Resume Checks

- Required before Step 02 for existing codebases.
- May be run during Step 88 exploration when codebase understanding is needed to clarify scope, constraints, risks, or alternatives.
- Optional for greenfield projects.
- Do not mark Step 99 complete without explicit approval.
- If resuming later, re-evaluate the current codebase before relying on any previous Step 99 summary.
- Reuse a previous Step 99 only if it still reflects the current codebase and approved Step 01 scope; update or rerun it if stale, incomplete, or scoped to a rejected exploration direction.
- Reject inconsistent journal states where Step 02+ is complete while Step 99 is required and incomplete.

## Draft Output

Load `templates/99-existing-codebase-understanding.md` before drafting the artifact.

Wait for approval.

## Approval Protocol

- Mark complete, save, or update `_spec-journal.json` only after explicit approval.
- On rejection, requested changes, hold, or ambiguous approval, do not persist progress; clarify or wait.
- If writes are unavailable, stop and report the limitation.

## Save Flow After Approval

1. Ask whether to persist `99-existing-codebase-understanding.md` in the resolved workflow directory; saving this snapshot is optional.
2. If persistence is approved, save `99-existing-codebase-understanding.md`.
3. Mark Step 99 in journal-only `_spec-journal.json`:
   - `status: "complete"` with the saved link when persisted.
   - `status: "requires_rerun"` with a reason when approved without persistence.
4. Ask whether to continue to the next step or hold.

For legacy or user-provided workflow paths, save and update progress in the resolved directory instead.

## Response Format

1. Gate and resume check result
2. Draft summary with required Step 99 headings
3. Persistence choice: save artifact vs. approved-not-saved rerun note
4. Approval request and continue/hold prompt
