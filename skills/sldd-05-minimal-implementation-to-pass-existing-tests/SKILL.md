---
name: sldd-05-minimal-implementation-to-pass-existing-tests
description: Write the minimal production code needed to make all existing failing tests pass. No extra features, no test modifications, no refactoring. Use after tests are written and confirmed failing.
metadata:
  step: "05"
  type: implementation
---

# Skill: Minimal Implementation to Pass Existing Tests

## Language

At the start of this step, before any other action:

1. Detect the user's current language from their latest message.
2. Use that language for all responses, drafts, questions, gate messages, and saved files, and switch immediately if the user changes language.
3. If the language is unclear, ask once before continuing.

### Language Compliance Check (mandatory before every reply)

Before sending any user-facing message, validate language compliance:
- The full response (including final review/approval prompts) must be in the user's current language.
- All the pre-defined replies must be translated to the user's current language.
- If this skill contains example text in another language, translate the meaning; do not copy that text literally.
- If any sentence is not in the user's current language, rewrite the response before sending.

---

## 🚨 GATE ENFORCEMENT (Read First)

**Before producing any implementation output, verify prerequisites.**

### Prerequisite Check

Step 05 requires **Steps 01, 02, 03, and 04 to be complete and approved**.

1. **Verify Steps 01-04 approval from available context:**
   - If a `SPEC.md` path is provided, read it and verify Steps 01, 02, 03, and 04 are marked `[x]`.
   - Otherwise, if approved Step 03 low-level design and approved Step 04 failing-test context are explicitly provided in the prompt/context, treat that as the prerequisite input for this step.
   - If neither an approved prior-step state nor approved prior-step context is available, stop for a gate violation.

2. **If violation detected:**
   → **STOP**. Reply in the user's language with this meaning:
> Cannot proceed to Step 05 because one or more prerequisite steps (01-04) are not complete/approved; show status per prerequisite, restate gate rule, and request completion/approval first.

3. **If Steps 01-04 approval is verified:** extract the approved low-level design and failing-test context and proceed with Step 05.

### Skip-Ahead Detection

If user asks to "skip tests", "skip Step 04", "go straight to code" at this stage:
→ **STOP**. Reply in the user's language that Step 04 tests are mandatory before Step 05 implementation.

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
2. **VIOLATION CHECK:** If Step 05 is marked [x] but any of Steps 01, 02, 03, or 04 is NOT marked [x] → this is a gate violation. Warn the user, refuse to continue from that state, and ask them to correct the SPEC progress first.
3. If Step 03 is marked complete, extract its section as the low-level design — no need to paste it manually.
4. If Step 04 is marked complete, extract the test file locations and run commands from its section — no need to provide them manually.
5. If Step 99 is marked complete, include the codebase context (language, conventions, architecture) as additional input.
6. Announce in the user's language that SLDD is resuming, list completed steps, and indicate continuation with Step 05.

If the user provides a specs root directory instead of a full path, list the available `SPEC.md` files under it and ask which feature to resume.

---

## Objective

Implement only the production code required to make all existing tests pass. Do not add features not covered by tests. Do not refactor unless tests fail.

Core constraints:
- Do not modify test files.
- Do not add features outside the approved design and existing tests.
- Do not refactor unless needed to make the existing tests pass.
- If the low-level design seems wrong, propose a design amendment instead of changing the architecture.

**Audience:**
Engineers and code reviewers verifying that implementation matches the low-level design and test intentions.

**Before writing any production code:**
- Check whether an `AGENTS.md` file exists at the project root. If it references a testing guideline file, read it.
- Keep all tests untouched, and follow the project's existing architecture and code style conventions.

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

---

## Save Flow (only after user approval)

### Plan Mode Check

First, check whether file writes are currently allowed:
- **If file writes are FORBIDDEN** (plan mode): tell the user in the user's language that plan mode cannot write production code and they must switch to build/execution mode.
- **If file writes are ALLOWED and user approved:** proceed to write production code.

### Write And Verify Production Code

1. Write production code following the low-level design
2. Run `./mvnw test` (or equivalent) to verify tests pass
3. Confirm all Step 04 tests now pass

### Update SPEC.md (Only After Tests Pass)

**Now** update SPEC.md:

1. Read the existing SPEC.md
2. Mark `[x]` next to Step 05 in SPEC.md
3. Do NOT copy implementation code into SPEC.md

### Final Verification

After updating SPEC.md, read it and confirm:
- [ ] SPEC.md Progress shows Step 05 as `[x]`
- [ ] SPEC.md does NOT contain any production code

### Report Results

Report:
- Which tests pass
- Confirmation that all tests pass

---

### Approval Confirmation

After marking Step 05 as `[x]` and updating `SPEC.md`, use **sldd-98-approval-helper** for the standardized completion and proceed prompt.
