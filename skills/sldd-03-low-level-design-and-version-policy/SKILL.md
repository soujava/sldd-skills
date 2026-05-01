---
name: sldd-03-low-level-design-and-version-policy
description: Produce Step 03 low-level design with API contracts, data models, error model, test strategy, and version policy.
metadata:
  step: "03"
  type: specification
---

# Skill: Low-Level Design and Version Policy

## Objective

Produce approved Step 03 low-level design and version policy aligned to Step 02 for Steps 04 and 05, including traceability from Step 01 requirements and Step 02 design decisions to contracts, data models, error handling, tests, dependencies, and implementation order.

## Gate + Resume Checks

- Require Step 01 and Step 02 approved.
- For existing codebases, require Step 99 approved.
- Reject implementation/test generation at this step.
- Reject inconsistent checklist states.

## Draft Output

Create a draft with these required Step 03 headings:

- Requirement-to-Design Traceability
- API Contracts
- Data Models
- Error Model
- Test Strategy
- Test Scenario Catalog
- Dependency and Version Policy
- Ordered Implementation Plan

If `00-exploration-summary.md` exists, use it only as contextual memory for rationale, alternatives, assumptions, and candidate technical ideas; do not import its design ideas as approved low-level decisions.
The draft must explicitly map Step 01 requirements and Step 02 design choices into concrete low-level decisions.
Include ordered implementation plan.
The draft must explicitly state:
- how each approved requirement is covered by API contracts, data models, error handling, tests, or implementation steps
- which Step 02 design decisions constrain Step 04 tests and Step 05 implementation
- whether the current dependency set is sufficient
- which new dependencies are required, if any
- why each dependency is needed
- version pinning or compatibility constraints for each new dependency
- the impact on runtime behavior, tests, and maintenance
Wait for approval.

## Approval Protocol

- Ask for explicit approval before saving or updating any artifact.
- Save/update only after explicit approval.
- If approval is rejected, requested changes are given, or the user asks to hold, leave progress unchanged and wait.
- If approval intent is ambiguous, ask for clarification instead of saving.
- If writes are unavailable, stop and report the limitation.

## Save Flow (after approval)

1. Save `docs/specs/<feature-name>/03-low-level-design-and-version-policy.md`.
2. Verify artifact contains Step 03 content only.
3. Update `SPEC.md` Step 03 `[x]` with link.
4. Verify `SPEC.md` remains journal-only.
5. Ask whether to continue to the next step or hold.

## Response Format

1. Gate and resume check result
2. Draft summary with required Step 03 headings
3. Approval request
4. Continue/hold prompt
