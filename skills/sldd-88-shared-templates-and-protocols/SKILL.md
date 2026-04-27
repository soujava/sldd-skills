---
name: sldd-88-shared-templates-and-protocols
description: Shared SLDD protocol for artifact layout, SPEC.md journal rules, gates, and compact step templates.
metadata:
  step: "88"
  type: shared
---

# Skill: Shared Templates and Protocols

Use this skill as the single source of truth for SLDD process mechanics.

## Objective

Define canonical SLDD process rules so all step skills apply consistent gates, approval behavior, artifact structure, and output contracts.

## 0) Independence Rule

All SLDD skills are self-contained and must not depend on `AGENTS.md` for language or `specs-dir`.
Use user input when provided; otherwise default to `docs/specs/<feature-name>/`.

## 1) Artifact Protocol

Use this exact structure:

```text
docs/specs/<feature-name>/
  SPEC.md
  01-product-intent-specification.md
  99-existing-codebase-understanding.md (optional persisted snapshot)
  02-high-level-technical-design.md
  03-low-level-design-and-version-policy.md
  04-tests-first-report.md
  05-minimal-implementation-report.md
  06-verification-and-feedback-report.md
```

Rules:
- `SPEC.md` is journal-only (progress + links or save-status notes).
- Step bodies go only to numbered artifacts.
- Step 99 may be approved without persisting its artifact; if omitted, record only the save status in `SPEC.md` and re-run Step 99 when resuming before Step 02.
- Never write step content into `SPEC.md`.

## 2) SPEC.md Journal Template

```markdown
# SPEC: <feature name>

## Progress
- [ ] Step 01 — Product Intent Specification -> 01-product-intent-specification.md
- [ ] Step 99 — Existing Codebase Understanding (required for existing codebases) -> 99-existing-codebase-understanding.md or not saved; re-run on resume
- [ ] Step 02 — High-Level Technical Design -> 02-high-level-technical-design.md
- [ ] Step 03 — Low-Level Design and Version Policy -> 03-low-level-design-and-version-policy.md
- [ ] Step 04 — Tests First Report (Red phase, failing tests required) -> 04-tests-first-report.md
- [ ] Step 05 — Minimal Implementation Report (must not modify tests) -> 05-minimal-implementation-report.md
- [ ] Step 06 — Verification and Feedback Report (Go/No-Go) -> 06-verification-and-feedback-report.md
```

## 3) Gate Rules

- Step 01 before Step 02.
- Step 99 required before Step 02 for existing codebases.
- Step 02 and Step 03 approved before Step 04.
- Step 04 must prove failing tests (Red).
- Step 05 must not modify tests from Step 04.
- Step 06 must include explicit Go/No-Go decision.

Violation handling: stop, report missing prerequisite, route back.

## 4) Save + Approval Protocol (Two-Phase Verification)

For every technical step involving codebase modifications or environment changes:

### Phase 1: Action Plan Approval (Pre-Execution)
1. Before performing any operations that modify the codebase, file system, or execute environment-altering commands, present a detailed **Action Plan**.
2. The plan must specify: files to be created or modified, the logic to be introduced, and the verification commands to be used.
3. **Hard Gate:** Do NOT perform any implementation or execution actions until this plan receives explicit approval.

### Phase 2: Report and Artifact Approval (Post-Execution)
1. After executing the approved plan, present the draft of the artifact containing the actual evidence (logs, test results, or specific outcomes).
2. Wait for explicit approval before persisting the artifact or updating progress.

Use `sldd-88-approval-helper` for approval messaging.

## 5) Shared Save Decision (apply in all steps)

- If writes are unavailable, stop and report limitation.
- If writes are available, save only after explicit approval.

## 6) Compact Step Template Contracts

Use these required headings (minimal contract):

- `01-product-intent-specification.md`:
  - Problem Statement
  - Target Users
  - Success Metrics
  - Out of Scope
  - Risks and Assumptions
  - Acceptance Criteria (Given/When/Then)

- `99-existing-codebase-understanding.md` (when persisted):
  - Repository Structure Overview
  - Architecture Summary
  - Conventions to Preserve
  - Integration Points
  - Risks and Unknowns
  - Context to Carry Into Steps 02-06

- `02-high-level-technical-design.md`:
  - Architecture Diagram
  - Component Responsibilities
  - Data Flow
  - Security and Observability Requirements
  - Trade-Offs and Alternatives
  - High-Level Test Scenario Map

- `03-low-level-design-and-version-policy.md`:
  - API Contracts
  - Data Models
  - Error Model
  - Test Strategy
  - Test Scenario Catalog
  - Dependency and Version Policy
  - Ordered Implementation Plan

- `04-tests-first-report.md`:
  - Test Files Created
  - Acceptance Criteria -> Tests Mapping
  - Test Commands Executed
  - Failing Results Summary
  - Red-Phase Confirmation

- `05-minimal-implementation-report.md`:
  - Production Files Changed
  - Implementation Notes (Minimal Scope)
  - Test Commands Executed
  - Passing Results Summary
  - Assumptions and Constraints
  - Test Integrity Confirmation (No Test Modifications)

- `06-verification-and-feedback-report.md`:
  - Compliance Matrix
  - Version and Dependency Validation
  - Test Convention Compliance
  - Risks by Severity
  - Remediation Steps
  - Go/No-Go Decision and Rationale

## Output Format and Contract References

- Step skills should reference this protocol instead of repeating boilerplate.
- Outputs should include only step-specific deltas and required approval prompts.
