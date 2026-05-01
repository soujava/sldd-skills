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

If `00-exploration-summary.md` exists, use it only as contextual memory for rationale, alternatives, assumptions, and candidate technical ideas; do not import its design ideas as approved architecture.
The draft must explicitly trace approved Step 01 requirements, including exploration outcomes formalized into Step 01, into the proposed architecture, component responsibilities, data flow, security/observability requirements, trade-offs, and high-level test scenarios.
Wait for approval.

## Approval Protocol

- Ask for explicit approval before saving or updating any artifact.
- Save/update only after explicit approval.
- If approval is rejected, requested changes are given, or the user asks to hold, leave progress unchanged and wait.
- If approval intent is ambiguous, ask for clarification instead of saving.
- If writes are unavailable, stop and report the limitation.

## Save Flow (after approval)

1. Save `docs/specs/<feature-name>/02-high-level-technical-design.md`.
2. Verify artifact contains Step 02 content only.
3. Update `SPEC.md` Step 02 `[x]` with link.
4. Verify `SPEC.md` remains journal-only.
5. Ask whether to continue to the next step or hold.

## Response Format

1. Gate and resume check result
2. Draft summary with required Step 02 headings
3. Approval request
4. Continue/hold prompt
