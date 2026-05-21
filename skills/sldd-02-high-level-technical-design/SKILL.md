---
name: sldd-02-high-level-technical-design
description: Produce Step 02 high-level design after prerequisite validation and save as a numbered artifact.
metadata:
  step: "02"
  type: specification
---

# Skill: High-Level Technical Design

## Objective

Produce approved Step 02 high-level design aligned to Step 01, including exploration outcomes formalized into Step 01, and Step 99 when required.

## Gate + Resume Checks

- Require Step 01 approved.
- For existing codebases, require Step 99 approved.
- Accept a Step 99 approved during exploration only after validating that it still reflects the current codebase and applies to the approved Step 01 scope.
- Reject skip-ahead to implementation/tests.
- Reject inconsistent checklist states.

## Draft Output

Create a draft with these required Step 02 headings:

- Requirements Traceability
- Architecture Diagram
- Component Responsibilities
- Data Flow
- Security and Observability Requirements
- Trade-Offs and Alternatives
- High-Level Test Scenario Map

Use `00-exploration-summary.md` only as non-binding context for rationale, alternatives, assumptions, and candidate technical ideas; approved numbered artifacts override it.
If Step 99 was completed before Step 01, verify that its context still fits the approved Step 01 scope before drafting Step 02. If it does not, stop and route back to Step 99 for update or rerun.
Trace approved Step 01 requirements, including formalized exploration outcomes, into architecture, responsibilities, data flow, security/observability, trade-offs, and high-level test scenarios.
Wait for approval.

## Approval Protocol

- Save or update artifacts only after explicit approval.
- On rejection, requested changes, hold, or ambiguous approval, do not persist progress; clarify or wait.
- If writes are unavailable, stop and report the limitation.

## Save Flow (after approval)

1. Save only Step 02 content to `docs/specs/<feature-name>/02-high-level-technical-design.md`.
2. Mark Step 02 complete in journal-only `docs/specs/<feature-name>/SPEC.md` with the artifact link.
3. Ask whether to continue to the next step or hold.

## Response Format

1. Gate and resume check result
2. Draft summary with required Step 02 headings
3. Approval request
4. Continue/hold prompt
