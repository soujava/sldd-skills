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

Wait for approval.

## Approval Protocol

- Save or update artifacts only after explicit approval.
- On rejection, requested changes, hold, or ambiguous approval, do not persist progress; clarify or wait.
- If writes are unavailable, stop and report the limitation.

## Save Flow After Approval

1. Save only Step 06 report content to the resolved workflow directory as `06-verification-and-feedback-report.md`; for new workflows, this is `.sldd/specs/<feature-name>/06-verification-and-feedback-report.md`.
2. Mark Step 06 as `complete` in journal-only `_spec-journal.json` with the artifact link.
3. Ask whether to continue to the next step or hold.

For legacy or user-provided workflow paths, save and update progress in the resolved directory instead.

## Response Format

1. Gate and resume check result
2. Draft summary with required Step 06 headings
3. Approval request
4. Continue/hold prompt
