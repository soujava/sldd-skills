---
name: sldd-05-minimal-implementation-to-pass-existing-tests
description: Write the minimal production code needed to make all existing failing tests pass. No extra features, no test modifications, no refactoring. Use after tests are written and confirmed failing.
metadata:
  step: "05"
  type: implementation
---

# Skill: Minimal Implementation to Pass Existing Tests

## Project Settings

At the start of this step, before any other action:

1. **Read `AGENTS.md`** at the project root.
2. **Look for the `## SLDD` section** and extract:
   - `language` — use this for all conversation output and generated file content.
   - `specs-dir` — use this as the root directory for all spec file paths.
3. **Resolve language with this precedence:**
   - If the user explicitly requests a language in the current interaction, use it immediately.
   - Otherwise, use `language` from `AGENTS.md`.
   - If no language is configured, ask once, use the answer, and persist it in `AGENTS.md`.
4. **If the `## SLDD` section is missing:** ask the user to run `sldd-00` first to configure project settings, or ask them directly (in the resolved language) for preferred language and specs directory.
5. **Apply these settings throughout this step** — all responses, drafts, questions, gate messages, and saved files must use the resolved language and specs directory.

### Language Compliance Check (mandatory before every reply)

Before sending any user-facing message, validate language compliance:
- The full response (including final review/approval prompts) must be in the resolved language.
- The pre-defined replies ("yes, continue", "no", "approved, proceed to Step X", etc.) must be translated to the resolved language.
- If this skill contains example text in another language, translate the meaning; do not copy that text literally.
- If any sentence is not in the resolved language, rewrite the response before sending.

---

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
   → **STOP**. Reply in the resolved language with this meaning:
> Cannot proceed to Step 05 because one or more prerequisite steps (01-04) are not complete/approved; show status per prerequisite, restate gate rule, and request completion/approval first.

3. **If Steps 01, 02, 03, and 04 are complete [x]:**
   - Extract Step 03 content as context
   - Extract test files and commands from Step 04
   - Proceed with Step 05

### Skip-Ahead Detection

If user asks to "skip tests", "skip Step 04", "go straight to code" at this stage:
→ **STOP**. Reply in the resolved language that Step 04 tests are mandatory before Step 05 implementation.

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
6. Announce in the resolved language that SLDD is resuming, list completed steps, and indicate continuation with Step 05.

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
- **If file writes are FORBIDDEN** (plan mode): tell the user in the resolved language that plan mode cannot write production code and they must switch to build/execution mode.
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

---

### Approval Confirmation

After marking Step 05 as [x] and updating SPEC.md, present:

```
## ✅ Step 05 complete and saved to: <file>

**Progress updated:**
- [x] Step 01 — Product Intent Specification -> 01-product-intent-specification.md
- [x] Step 02 — High-Level Technical Design -> 02-high-level-technical-design.md
- [x] Step 03 — Low-Level Design and Version Policy -> 03-low-level-design-and-version-policy.md
- [x] Step 04 — Tests (written and confirmed failing)
- [x] Step 05 — Implementation (all tests passing)

---

**Proceed to the next step?**

- **Yes**: Reply "yes, continue to Step 06"  
- **No**: Reply "no, wait for instructions"  
- **Approve and continue**: Reply "approved, proceed to Step 06"
```

**THE PRE-DEFINED REPLIES ("yes, continue", "no", "approved, proceed to Step X", etc.) MUST BE TRANSLATED TO THE RESOLVED LANGUAGE.**
