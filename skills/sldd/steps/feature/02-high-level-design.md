# Step 02: High-Level Technical Design

## Objective

Produce approved high-level design aligned to Step 01, including exploration outcomes formalized into Step 01 and Step 99 when required.

## Gate + Resume Checks

- Require Step 01 complete.
- For existing codebases, require Step 99 complete and current.
- Accept a persisted Step 99 completed during exploration only after validating that it still reflects the current codebase and applies to the approved Step 01 scope.
- Reject skip-ahead to implementation/tests.
- Reject inconsistent journal states.

## Draft Output

Load `templates/02-high-level-technical-design.md` before drafting the artifact.

Use `00-exploration-summary.md` only as non-binding context for rationale, alternatives, assumptions, and candidate technical ideas. Approved numbered artifacts override it.

If Step 99 was completed before Step 01, verify that its saved context still fits the approved Step 01 scope before drafting Step 02. If it does not, stop and route back to Step 99 for update or rerun.

Trace approved Step 01 requirements, including formalized exploration outcomes, into architecture, responsibilities, data flow, security/observability, trade-offs, and high-level test scenarios.

Save the draft for review, keep the step pending, then wait for explicit approval.

## Approval Protocol

- Save or update the Step 02 artifact as a reviewable draft before gate approval.
- Draft persistence must keep `02-high-level-design` as `pending` in `_spec-journal.json`, preserve the artifact link, and set `reason` to `draft pending explicit approval` or an equivalent review reason.
- The existence of `02-high-level-technical-design.md` does not satisfy the Step 02 gate.
- On rejection, requested changes, hold, or ambiguous approval, update the draft when needed, keep the step pending, and do not route to Step 03+.
- Only explicit approval of the current draft may mark Step 02 complete.
- If writes are unavailable, stop and report the limitation.

## Draft Save Flow

1. Save only Step 02 content to the resolved workflow directory as `02-high-level-technical-design.md`; for new workflows, this is `.sldd/specs/<feature-name>/02-high-level-technical-design.md`.
2. Update journal-only `_spec-journal.json` with `steps["02-high-level-design"].status: "pending"`, the artifact link, and `reason: "draft pending explicit approval"`.
3. Ask for explicit approval, revision requests, or hold.

## Gate Approval Flow

1. On explicit approval of the current draft, mark `02-high-level-design` as `complete` in journal-only `_spec-journal.json` with the artifact link.
2. Ask whether to continue to the next step or hold.

For legacy or user-provided workflow paths, save the draft and update progress in the resolved directory instead.

## Response Format

1. Gate and resume check result
2. Saved draft summary with required Step 02 headings
3. Pending journal update and explicit approval request
4. Continue/hold prompt after approval, or revision/hold prompt while pending
