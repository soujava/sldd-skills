---
name: sldd-06-verification-and-feedback-report
description: Audit implementation against approved specs and produce final Go/No-Go decision.
metadata:
  step: "06"
  type: verification
---

# Skill: Verification and Feedback Report

## Objective

Produce approved Step 06 verification with explicit Go/No-Go decision.

## Gate + Resume Checks

- Require Steps 01-05 approved.
- For existing codebases, require Step 99 approved.
- Reject premature verification before implementation completion.
- Reject inconsistent checklist states.

## Draft Output

Create a draft with these required Step 06 headings:

- Compliance Matrix
- Version and Dependency Validation
- Test Convention Compliance
- Risks by Severity
- Remediation Steps
- Go/No-Go Decision and Rationale

Wait for approval.

## Approval Protocol

- Save or update artifacts only after explicit approval.
- On rejection, requested changes, hold, or ambiguous approval, do not persist progress; clarify or wait.
- If writes are unavailable, stop and report the limitation.

## Save Flow (after approval)

1. Save only Step 06 report content to `docs/specs/<feature-name>/06-verification-and-feedback-report.md`.
2. Mark Step 06 complete in journal-only `docs/specs/<feature-name>/SPEC.md` with the artifact link.
3. Ask whether to continue to the next step or hold.

## Response Format

1. Gate and resume check result
2. Draft summary with required Step 06 headings
3. Approval request
4. Continue/hold prompt
