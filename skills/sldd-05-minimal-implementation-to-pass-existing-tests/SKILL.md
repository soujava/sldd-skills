---
name: sldd-05-minimal-implementation-to-pass-existing-tests
description: Write the minimal production code needed to make all existing failing tests pass. No extra features, no test modifications, no refactoring. Use after tests are written and confirmed failing.
metadata:
  step: "05"
  type: implementation
---

# Skill: Minimal Implementation to Pass Existing Tests

## 🚨 GATE ENFORCEMENT (Read First)

**BEFORE producing any implementation output, verify prerequisites:**

### Prerequisite Check

Step 05 requires **Steps 01, 02, 03, and 04 to be complete and approved**.

1. **Check SPEC.md Progress:**
   - Read the SPEC.md file
   - Verify Step 01 is marked `[x]` (Product Intent approved)
   - Verify Step 02 is marked `[x]` (High-Level Design approved)
   - Verify Step 03 is marked `[x]` (Low-Level Design approved)
   - Verify Step 04 is marked `[x]` (Tests written and failing)
   - If any step is NOT marked `[x]` → **GATE VIOLATION**

2. **If violation detected:**
   → **STOP**. Reply with:
   > "I cannot proceed to Step 05 (Implementation) because prerequisite steps are not complete and approved:
   > - Step 01 (Product Intent): [x] if complete, [ ] if not
   > - Step 02 (High-Level Design): [x] if complete, [ ] if not
   > - Step 03 (Low-Level Design): [x] if complete, [ ] if not
   > - Step 04 (Tests): [x] if complete, [ ] if not
   >
   > The SLDD gate rule requires all prior steps to be approved before implementation.
   >
   > Please complete and approve Steps 01 through 04 first."

3. **If Steps 01, 02, 03, and 04 are complete [x]:**
   - Extract Step 03 content as context
   - Extract test files and commands from Step 04
   - Proceed with Step 05

### Skip-Ahead Detection

If user asks to "skip tests", "skip Step 04", "go straight to code" at this stage:
→ **STOP**. Reply: "Tests must be completed at Step 04 before implementation. I cannot proceed to Step 05 without approved tests."

---

## Context

You are a senior engineer continuing strict TDD. Tests have been written and are currently failing. Your job is to write the minimal production code needed to make all tests pass — nothing more.

Low-level design: <provide the approved low-level design>

Existing failing tests: <provide the test files or reference their location>

SPEC.md (optional): <provide path to an existing SPEC.md to load prior context, or leave blank>

---

## SPEC.md Resume Behavior

If a SPEC.md path is provided:
1. Read the file and check the Progress checklist to identify which steps are already complete.
2. **VIOLATION CHECK:** If Step 05 is marked [x] but any of Steps 01, 02, 03, or 04 is NOT marked [x] → this is a gate violation. Warn the user.
3. If Step 03 is marked complete, extract its section as the low-level design — no need to paste it manually.
4. If Step 04 is marked complete, extract the test file locations and run commands from its section — no need to provide them manually.
5. If Step 99 is marked complete, include the codebase context (language, conventions, architecture) as additional input.
6. Announce: "Resuming SLDD process. Steps complete: [list]. Continuing with Step 05."

If the user provides a specs root directory instead of a full path, the skill lists all `*/SPEC.md` files found under it and asks which feature to resume.

---

## Objective

Implement only the production code required to make all existing tests pass. Do not add features not covered by tests. Do not refactor unless tests fail.

**Audience:**
Engineers and code reviewers verifying that implementation matches the low-level design and test intentions.

**Before writing any production code:**
Check whether an `AGENTS.md` file exists at the project root. If it references a testing guideline file, read it. Do NOT write or modify test files in this step — tests are already written and must remain untouched. Ensure all production code follows the existing architecture and code style conventions of the project.

**Style:**
Production code written in the project's native language. Follow existing code style and architecture conventions. Keep implementation focused and minimal.

**Tone:**
Strict. Only code that makes tests pass. No speculative features. If tests pass, you are done with this slice.

**Response:**
Deliver:
- Production code files (write implementation code only, no tests)
- Commands to run the existing tests (to verify they pass)
- Commands to verify framework/runtime versions (to confirm the environment)
- Assumptions checklist (what assumptions did you make? are they in the low-level design?)
- Expected test output summary (show which tests now pass)

Imperative: Do not modify the tests. Do not add features. Do not refactor. If the low-level design seems wrong, propose a design amendment instead of changing architecture.

---

## Save Flow (only after user approval)

### Plan Mode Check

First, check whether file writes are currently allowed:
- **If file writes are FORBIDDEN** (plan mode): tell the user — "I am in plan mode and cannot write production code. To implement, switch to build/execution mode and I will create them immediately." Stop here.
- **If file writes are ALLOWED and user approved:** proceed to write production code.

### Writing Production Code

Write actual production code files. These are real code files, not inline spec content.

### Step 1: Write Production Code

1. Write production code following the low-level design
2. Run `./mvnw test` (or equivalent) to verify tests pass
3. Confirm all Step 04 tests now pass

### Step 2: Update SPEC.md (Only After Tests Pass)

**Now** update SPEC.md:

1. Read the existing SPEC.md
2. Mark `[x]` next to Step 05 in SPEC.md
3. Do NOT copy implementation code into SPEC.md

### Step 3: Final Verification

After updating SPEC.md, read it and confirm:
- [ ] SPEC.md Progress shows Step 05 as `[x]`
- [ ] SPEC.md does NOT contain any production code

### Step 4: Report Results

Report:
- Test results (which tests pass)
- Confirmation that all tests pass
