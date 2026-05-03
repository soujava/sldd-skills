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
- If resuming from `SPEC.md`, reject invalid state where later steps are complete but Step 01 is not.

## Draft Output

Create a draft with these required Step 01 headings:

- Problem Statement
- Target Users
- Formalized Exploration Decisions
- Success Metrics
- Out of Scope
- Risks and Assumptions
- Acceptance Criteria (Given/When/Then)

If `00-exploration-summary.md` exists, use it only as contextual memory for product intent, behavior, scope, risks, assumptions, and success metrics; do not import technical design ideas as binding Step 01 decisions.
If an approved Step 99 exists from brownfield exploration, use it only as contextual memory for risks, assumptions, constraints, dependencies, and out-of-scope boundaries. Do not import architecture or implementation observations as binding product requirements unless the user explicitly approves them as Step 01 product decisions.
Wait for approval.

## Approval Protocol

- Ask for explicit approval before saving or updating any artifact.
- Save/update only after explicit approval.
- If approval is rejected, requested changes are given, or the user asks to hold, leave progress unchanged and wait.
- If approval intent is ambiguous, ask for clarification instead of saving.
- If writes are unavailable, stop and report the limitation.

## Save Flow (after approval)

1. Save `docs/specs/<feature-name>/01-product-intent-specification.md`.
2. Verify artifact contains Step 01 content only.
3. Update `SPEC.md` Step 01 `[x]` with link.
4. Verify `SPEC.md` remains journal-only.
5. Ask whether to continue to the next step or hold.

## Response Format

1. Gate and resume check result
2. Draft summary with required Step 01 headings
3. Approval request
4. Continue/hold prompt
