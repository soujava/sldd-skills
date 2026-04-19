---
name: sldd-06-verification-and-feedback-report
description: Audit completed implementation against the spec and produce a gap report with compliance matrix, risks, remediation steps, and a go/no-go production readiness decision. Use after implementation is complete.
metadata:
  step: "06"
  type: verification
---

# Skill: Verification and Feedback Report

## 🚨 GATE ENFORCEMENT (Read First)

**BEFORE producing any verification output, verify prerequisites:**

### Prerequisite Check

Step 06 requires **ALL prior steps (01-05) to be complete and approved**.

1. **Check SPEC.md Progress:**
   - Read the SPEC.md file
   - Verify Step 01 is marked `[x]` (Product Intent approved)
   - Verify Step 02 is marked `[x]` (High-Level Design approved)
   - Verify Step 03 is marked `[x]` (Low-Level Design approved)
   - Verify Step 04 is marked `[x]` (Tests written and failing)
   - Verify Step 05 is marked `[x]` (Implementation complete)
   - If any step is NOT marked `[x]` → **GATE VIOLATION**

2. **If violation detected:**
   → **STOP**. Reply with:
   > "I cannot proceed to Step 06 (Verification) because prerequisite steps are not complete and approved:
   > - Step 01 (Product Intent): [x] if complete, [ ] if not
   > - Step 02 (High-Level Design): [x] if complete, [ ] if not
   > - Step 03 (Low-Level Design): [x] if complete, [ ] if not
   > - Step 04 (Tests): [x] if complete, [ ] if not
   > - Step 05 (Implementation): [x] if complete, [ ] if not
   >
   > The SLDD gate rule requires all prior steps to be complete before verification.
   >
   > Please complete and approve Steps 01 through 05 first."

3. **If Steps 01-05 are complete [x]:**
   - Extract Step 01, 03, and 05 content as context
   - Proceed with Step 06

### Skip-Ahead Detection

If user asks to "verify", "audit", "check against spec" before implementation is done:
→ **STOP**. Reply: "Verification requires implementation to be complete at Step 05 first. I cannot audit against a spec without code to verify."

---

## Context

You are reviewing completed implementation against the low-level design spec. It is time to audit whether the work matches intent and identify gaps, risks, or compliance issues before release.

Spec: <provide the approved low-level design and product intent specification>

Implementation summary: <provide the implementation output or reference files>

SPEC.md (optional): <provide path to an existing SPEC.md to load prior context, or leave blank>

---

## SPEC.md Resume Behavior

If a SPEC.md path is provided:
1. Read the file and check the Progress checklist to identify which steps are already complete.
2. **VIOLATION CHECK:** If Step 06 is marked [x] but any of Steps 01, 02, 03, 04, or 05 is NOT marked [x] → this is a gate violation. Warn the user.
3. If Step 01 is marked complete, extract its section as the product intent spec (problem statement, acceptance criteria) — no need to paste it manually.
4. If Step 03 is marked complete, extract its section as the low-level design to audit against — no need to paste it manually.
5. If Step 05 is marked complete, extract the implementation summary (production files, run commands, assumptions) from its section — no need to provide it manually.
6. Announce: "Resuming SLDD process. Steps complete: [list]. Continuing with Step 06."

If the user provides a specs root directory instead of a full path, list all `*/SPEC.md` files found under it and ask which feature to resume.

---

## Objective

Produce a gap report that compares the implementation against the spec and identifies what matches, what is missing, what risks remain, and whether the work is production-ready.

**Audience:** Engineers, tech leads, QA, and release managers deciding whether this work is ready to merge and ship.

**Style:** Structured report with matrices, lists, and clear status indicators (met/partial/missing). Prioritize risks by severity.

**Tone:** Critical and honest. Flag every gap and risk. Provide actionable remediation steps. Give a clear yes/no on production readiness.

---

## Response

Before auditing, check whether an `AGENTS.md` file exists at the project root. If it references a testing guideline file, read it and use it as the baseline for test convention compliance checks.

Deliver exactly these sections in this order:
1) Compliance matrix (spec requirement → implementation status: met/partial/missing)
2) Version and dependency validation (are versions correct and supported?)
3) Test convention compliance: verify that test files follow the project's testing guideline (from `AGENTS.md` if present). Flag any tests that violate naming conventions, assertion style, soft assertion usage, AAA structure, or exception testing patterns.
4) Risk list by severity (high/medium/low)
5) Suggested remediation steps (how to fix gaps before release)
6) Decision: ready for production? yes/no and why. If no, list the top 3 blockers.

---

## Draft Output

**Present the following sections as a draft — this is NOT yet saved to any file.**
The user will review and approve before any files are written.

Deliver exactly these sections:
1) Compliance matrix (spec requirement → implementation status: met/partial/missing)
2) Version and dependency validation (are versions correct and supported?)
3) Test convention compliance: verify that test files follow the project's testing guideline (from `AGENTS.md` if present). Flag any tests that violate naming conventions, assertion style, soft assertion usage, AAA structure, or exception testing patterns.
4) Risk list by severity (high/medium/low)
5) Suggested remediation steps (how to fix gaps before release)
6) Decision: ready for production? yes/no and why. If no, list the top 3 blockers.

After presenting the draft, say:
> "Step 06 (Verification and Feedback Report) draft is ready for your review. This is the final gate before production. Please approve or provide feedback."

**Wait for user approval before proceeding to the save step.**

---

## Save Flow (only after user approval)

### ⚠️ CRITICAL: SPEC.md Structure Rule

**SPEC.md must contain ONLY the Progress checklist — never the step content itself.**

| File | Contents |
|------|----------|
| `SPEC.md` | Progress checklist + links only |
| `06-verification-and-feedback-report.md` | Step 06 content (six sections) |

**❌ WRONG — Do NOT do this:**
```markdown
# SPEC: My Feature
- [x] Step 01
- [x] Step 02
- [x] Step 03
- [x] Step 04
- [x] Step 05
## Compliance Matrix
...
## Risks
...
```

**✅ CORRECT — Do THIS:**
```markdown
# SPEC: My Feature
## Progress
- [x] Step 01 — Product Intent Specification -> 01-product-intent-specification.md
- [x] Step 02 — High-Level Technical Design -> 02-high-level-technical-design.md
- [x] Step 03 — Low-Level Design and Version Policy -> 03-low-level-design-and-version-policy.md
- [x] Step 04 — Tests (written and confirmed failing)
- [x] Step 05 — Implementation (all tests passing)
- [ ] Step 06 — Verification Report -> 06-verification-and-feedback-report.md
```

---

### Step 1: Create the Step File (First!)

**Create the numbered step file BEFORE touching SPEC.md.**

1. Confirm the directory path from previous steps (should be `docs/specs/<feature-slug>/`)
2. Create `<dir>/06-verification-and-feedback-report.md` with the six sections
3. **STOP. Do NOT touch SPEC.md yet.**

### Step 2: Verify the Step File

Read the file you just created and verify:
- [ ] It contains the six sections (Compliance Matrix, Version/Dependency Validation, Test Convention Compliance, Risks, Remediation, Decision)
- [ ] It does NOT contain a "Progress" section
- [ ] It does NOT duplicate content that belongs in other steps

If verification fails, fix the step file before proceeding.

### Step 3: Update SPEC.md (Only After Verification Passes)

**Now** update SPEC.md:

1. Read the existing SPEC.md
2. Mark `[x]` next to Step 06 and link to `06-verification-and-feedback-report.md`
3. **Do NOT copy the six sections into SPEC.md**

### Step 4: Final Verification

After updating SPEC.md, read it and confirm:
- [ ] SPEC.md contains ONLY the Progress checklist
- [ ] SPEC.md does NOT contain the step content (Compliance Matrix, Risks, etc.)
- [ ] The Progress checklist shows Step 06 as `[x]` with a link

If verification fails, remove any incorrectly added content from SPEC.md.

---

### Save Decision (Fallback)

First, check whether file writes are currently allowed:
- **If file writes are FORBIDDEN** (plan mode): tell the user — "I am in plan mode and cannot write files right now. To save this spec output, switch to build/execution mode and I will create it immediately." Stop here.
- **If file writes are ALLOWED and user approved:** ask "Save this spec output to a file? (yes/no)"
- **If no:** continue without saving. The draft is discarded.

### Existing SPEC.md

If a SPEC.md exists and user says yes, follow the **4-step process above**.
