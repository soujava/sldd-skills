# Step 06: Verification and Feedback Report

## Objective

Produce approved verification with explicit Go/No-Go decision.

## Gate + Resume Checks

- Require Steps 01-05 complete.
- Require Step 04 evidence `red_confirmed`.
- Require Step 05 evidence `green_confirmed`.
- For existing codebases, require Step 99 complete and current.
- Reject premature verification before implementation completion.
- Reject inconsistent journal states.

## Draft Output

Load `templates/06-verification-and-feedback-report.md` before drafting the artifact.

The Step 06 verification report must include an `Architecture Compliance Matrix` section. For every mandatory architecture decision from Step 03, report:

- Decision ID
- required mechanism
- implemented mechanism
- evidence file(s)
- verification command(s)
- result: `satisfied`, `environment-blocked`, or `violated`
- Go/No-Go impact

A `violated` mandatory decision requires a No-Go decision. An `environment-blocked` mandatory decision may still allow Go only when the approved mechanism is implemented in production code, the blockage is limited to local verification infrastructure, no unapproved fallback was introduced, and remediation steps are documented.

Save the draft report for review, keep the step pending, then wait for explicit approval.

## Approval Protocol

- Save or update the Step 06 report as a reviewable draft before gate approval.
- Draft persistence must keep `06-verification` as `pending` in `_spec-journal.json`, preserve the artifact link, and set `reason` to `draft pending explicit approval` or an equivalent review reason.
- The existence of `06-verification-and-feedback-report.md` does not complete the workflow.
- On rejection, requested changes, hold, or ambiguous approval, update the draft report when needed, keep the step pending, and do not mark the feature workflow complete.
- Only explicit approval of the current draft report may mark Step 06 complete.
- If writes are unavailable, stop and report the limitation.

## Draft Save Flow

1. Save only Step 06 report content to the resolved workflow directory as `06-verification-and-feedback-report.md`; for new workflows, this is `.sldd/specs/<feature-name>/06-verification-and-feedback-report.md`.
2. Update journal-only `_spec-journal.json` with `steps["06-verification"].status: "pending"`, the artifact link, and `reason: "draft pending explicit approval"`.
3. Ask for explicit approval, revision requests, or hold.

## Gate Approval Flow

1. On explicit approval of the current draft report, mark `06-verification` as `complete` in journal-only `_spec-journal.json` with the artifact link.
2. State that the feature workflow is complete only after this journal update.

For legacy or user-provided workflow paths, save the draft and update progress in the resolved directory instead.

## Response Format

1. Gate and resume check result
2. Saved draft summary with required Step 06 headings
3. Pending journal update and explicit approval request
4. Workflow completion notice after approval, or revision/hold prompt while pending
