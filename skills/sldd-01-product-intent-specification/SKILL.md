---
name: sldd-01-product-intent-specification
description: Produce Step 01 intent spec with strict gate/resume checks and artifact-first save flow.
metadata:
  step: "01"
  type: specification
---

# Skill: Product Intent Specification

## Objective

Define and validate Step 01 product intent for downstream steps.

## Gate + Resume Checks

- Reject jump-ahead requests to design/tests/implementation.
- If resuming from `docs/specs/<feature-name>/SPEC.md`, reject invalid state where later steps are complete but Step 01 is not.

## Draft Output

Create a draft with these required Step 01 headings:

- Problem Statement
- Target Users
- Formalized Exploration Decisions
- Success Metrics
- Out of Scope
- Risks and Assumptions
- Acceptance Criteria (Given/When/Then)

Use `00-exploration-summary.md` only as non-binding context for product intent, behavior, scope, risks, assumptions, and success metrics; approved numbered artifacts override it.
Use an approved Step 99 from brownfield exploration only as context for risks, assumptions, constraints, dependencies, and out-of-scope boundaries; do not import architecture or implementation observations as product requirements unless explicitly approved as Step 01 decisions.
Wait for approval.

## Approval Protocol

- Save or update artifacts only after explicit approval.
- On rejection, requested changes, hold, or ambiguous approval, do not persist progress; clarify or wait.
- If writes are unavailable, stop and report the limitation.

## Save Flow (after approval)

1. Save only Step 01 content to `docs/specs/<feature-name>/01-product-intent-specification.md`.
2. Mark Step 01 complete in journal-only `docs/specs/<feature-name>/SPEC.md` with the artifact link.
3. Ask whether to continue to the next step or hold.

## Response Format

1. Gate and resume check result
2. Draft summary with required Step 01 headings
3. Approval request
4. Continue/hold prompt
