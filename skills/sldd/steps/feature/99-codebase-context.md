# Step 99: Existing Codebase Understanding and Context Summary

## Objective

Capture and approve existing-codebase context for brownfield exploration and safe Step 02+ work.

## Gate + Resume Checks

- Required before Step 02 for existing codebases.
- May be run during Step 88 exploration when codebase understanding is needed to clarify scope, constraints, risks, or alternatives.
- Optional for greenfield projects.
- Do not mark Step 99 complete without explicit approval of the current `existing-codebase-understanding.md` draft and a saved artifact link.
- Conversational, unsaved, or pending-draft Step 99 context is non-gating context only; it does not satisfy Step 02+ brownfield prerequisites.
- If resuming later, re-evaluate the current codebase before relying on any previous Step 99 summary.
- Reuse a previous Step 99 only if it still reflects the current codebase and approved Step 01 scope; update or rerun it if stale, incomplete, or scoped to a rejected exploration direction.
- Reject inconsistent journal states where Step 02+ is complete while Step 99 is required and incomplete.
- If `relationships.predecessors` exists and any predecessor is missing or incomplete, Step 99 may be drafted and saved as context, but must remain `pending` for gating purposes until Step 01 can complete after predecessor verification.

## Draft Output

Load `templates/existing-codebase-understanding.md` before drafting the artifact.

Save the draft for review, keep the step pending, then wait for explicit approval.

## Approval Protocol

- Save or update `existing-codebase-understanding.md` as a reviewable draft before gate approval.
- Draft persistence must keep `99-codebase-context` as `pending` in `_spec-journal.json`, preserve the artifact link, and set `reason` to `draft pending explicit approval` or a more specific blocking reason.
- The existence of `existing-codebase-understanding.md` does not satisfy the Step 99 or Step 02+ brownfield gate.
- On rejection, requested changes, hold, or ambiguous approval, update the draft when needed, keep Step 99 pending, and do not route to Step 02+.
- Only explicit approval of the current draft may mark Step 99 complete, and predecessor gates may still keep it pending.
- If writes are unavailable, stop and report the limitation.

## Draft Save Flow

1. Save only Step 99 context content to the resolved workflow directory as `existing-codebase-understanding.md`.
2. Create or update journal-only `_spec-journal.json` with required top-level fields when Step 99 is persisted before the journal exists.
3. Set `steps["99-codebase-context"].status: "pending"`, preserve the artifact link, and set `reason` to `draft pending explicit approval` unless a predecessor gate requires a more specific reason.
4. Ask for explicit approval, revision requests, or hold.

## Gate Approval Flow

1. On explicit approval of the current draft, verify predecessor gates and current codebase relevance again.
2. If `relationships.predecessors` exists and any predecessor is missing or incomplete, keep Step 99 as `pending`, preserve the artifact link, set `reason` to the predecessor-gate explanation, and route to the incomplete predecessor instead of Step 02+.
3. Otherwise, mark Step 99 in journal-only `_spec-journal.json` with `status: "complete"` and the saved artifact link.
4. Ask whether to continue to the next step or hold.

For legacy or user-provided workflow paths, save the draft and update progress in the resolved directory instead.

## Response Format

1. Gate and resume check result
2. Saved draft summary with required Step 99 headings
3. Pending journal update and explicit approval requirement for Step 99 completion
4. Continue/hold prompt after approval, or revision/hold prompt while pending
