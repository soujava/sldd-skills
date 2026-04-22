---
name: sldd-04-tests-first-driven-by-acceptance-criteria
description: Write test files driven by acceptance criteria in strict TDD mode. Create only minimal stubs for compilation. Language-agnostic. Use after the low-level design is approved.
metadata:
  step: "04"
  type: implementation
---

# Skill: Tests First Driven by Acceptance Criteria

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

**Before producing any test output, verify prerequisites.**

### Prerequisite Check

Step 04 requires **Steps 01, 02, and 03 to be complete and approved**.

1. **Verify Steps 01-03 approval from available context:**
   - If a `SPEC.md` path is provided, read it and verify Steps 01, 02, and 03 are marked `[x]`.
   - Otherwise, if approved Step 01 acceptance criteria and approved Step 03 low-level design are explicitly provided in the prompt/context, treat that as the prerequisite input for this step.
   - If neither an approved prior-step state nor approved prior-step context is available, stop for a gate violation.

2. **If violation detected:**
   → **STOP**. Reply in the user's language with this meaning:
> Cannot proceed to Step 04 because one or more prerequisite steps (01-03) are not complete/approved; show status per prerequisite, restate gate rule, and request completion/approval first.

3. **If Steps 01-03 approval is verified:** extract the approved Step 03 content and Step 01 acceptance criteria as context and proceed with Step 04.

### Skip-Ahead Detection

If user asks to "implement", "write production code", "skip tests", "just code it" at this stage:
→ **STOP**. Reply in the user's language that tests at Step 04 are required before any production code.

---

## Context

You are a senior engineer working in strict test-driven development (TDD) mode. You have a low-level design and acceptance criteria. Tests must be written first, before any production code.

Low-level design: <provide the approved low-level design>

Acceptance criteria: <provide the acceptance criteria from the product intent specification>

SPEC.md (optional): <provide path to an existing SPEC.md to load prior context, or leave blank>

---

## SPEC.md Resume Behavior

If a SPEC.md path is provided:
1. Read the file and check the Progress checklist to identify which steps are already complete.
2. **VIOLATION CHECK:** If Step 04 is marked [x] but any of Steps 01, 02, or 03 is NOT marked [x] → this is a gate violation. Warn the user, refuse to continue from that state, and ask them to correct the SPEC progress first.
3. If Step 03 is marked complete, extract its section as the low-level design — no need to paste it manually.
4. If Step 01 is marked complete, extract the acceptance criteria from its section — no need to paste them manually.
5. Announce in the user's language that SLDD is resuming, list completed steps, and indicate continuation with Step 04.

If the user provides a specs root directory instead of a full path, list the available `SPEC.md` files under it and ask which feature to resume.

---

## Objective

Write ONLY test files. Create ZERO production code files. Compile-time failures caused by missing modules/functions/classes are valid Red-phase outcomes. Create ONLY the minimal stubs needed for tests to compile, or to fail meaningfully because implementation is still missing:

### Stub Rules (STRICT)
- **Boundary components** (controllers, handlers, routes): Create module/class with method signatures only. Method body must raise a "not implemented" error — NEVER execute business logic or return any value.
- **Service components**: Create module/class with method signatures only. Method body must raise a "not implemented" error — NEVER execute business logic or return any value.
- **Data models**: Create structures with fields only. No validation, no computed properties, no side effects.
- **Errors/Exceptions**: Reuse existing error types from the project if available.
- **NO validation logic** in any stub — tests that expect validation failures will fail at runtime until Step 05.
- **NO business logic** — only signatures that raise "not implemented" errors. Zero-value returns are forbidden.

### Language-Agnostic Principles
- Stubs return/raise the equivalent of "not implemented" in the target language
- No framework-specific annotations or decorators that trigger behavior
- No business rules — only structural placeholders
- No hardcoded return values — stub must raise "not implemented" error, not return a value

### Why This Matters
TDD = Red (tests fail) → Green (minimal code passes) → Refactor. If you add business logic at Step 04, you skip the Red phase.

### Stub Compliance Checklist

- [ ] Service method raises a "not implemented" error — NOT a calculated value
- [ ] Boundary/Controller endpoint raises a "not implemented" error — NO validation logic
- [ ] No hardcoded return values (not even zero, empty string, false, null)
- [ ] All tests FAIL at Step 04 (both happy path AND validation/error scenarios)
- [ ] If any test passes at Step 04, the stub is incorrect — rollback and rebuild

### Anti-Patterns (NEVER DO)

| Anti-Pattern | Why It's Incorrect |
|---|---|
| `return 0`, `return ""`, `return null` | Happy path tests pass with placeholder value |
| `if (x == null) throw...` guard in stub | This is validation logic — belongs to Step 05 |
| `return a + b` or any formula | Business logic — belongs to Step 05 |

### TDD Red Phase Definition

At Step 04, **every** test must fail:
- **Happy path tests** → fail because the "not implemented" error is raised
- **Validation tests** → fail because the "not implemented" error is raised BEFORE validation logic executes
- **Any test that passes** → the stub contains logic it should not have

**Audience:**
Engineers who will run these tests immediately and implement code to make them pass.

**Before writing any tests:**
Check whether an `AGENTS.md` file exists at the project root. If it references a testing guideline file (e.g. `TESTING-GUIDELINE.adoc`), read it and apply all conventions found there to every test written. Conventions typically cover: test framework, assertion library, naming patterns, test structure (AAA), soft assertions, exception testing style, and coverage requirements.
If no guideline is found, fall back to the conventions of existing test files in the project as the baseline.

**Style:**
Test code in the project's native test framework. One test per clearly named scenario. Include brief comments explaining what each test validates. Naming, structure, and assertion style must follow the project's testing guideline if one exists.

**Tone:**
Explicit. Each test must map to one acceptance criterion. Leave no ambiguity about what passes or fails.

**Response:**
Deliver:
- Test files (write actual test code using the project's test framework)
- One test per acceptance criterion, plus at least one edge case test per criterion
- Commands to run the test suite

### Stub Creation Process
1. Write ALL test files first
2. For each test file that references a non-existent module/class/function, create ONLY:
    - The module/class/function declaration
    - Field/parameter declarations (if data model)
    - Method bodies that raise "not implemented" error — NEVER return a value
3. Run tests — they MUST fail in some way (Red phase): either compile-time errors or runtime failures
4. Do NOT add any business logic, validation, or implementation beyond stubs

### Verification
After creating stubs, run the test suite and confirm:
- Tests produce either compile-time or runtime failures
- Compile-time failures (missing methods, undefined types) are valid Red-phase outcomes
- Runtime failures (assertions failing, "not implemented" errors) are also valid Red-phase outcomes
- A successful compilation with all tests passing is NOT the expected outcome at Step 04

---

## Save Flow (only after user approval)

First, check whether file writes are currently allowed:
- **If file writes are FORBIDDEN** (plan mode): tell the user in the user's language that plan mode cannot write test files and they must switch to build/execution mode.
- **If file writes are ALLOWED and user approved:** proceed to write test files.

### Write And Verify Test Files

1. Write all test files to the project's test directories
2. Run the test suite to confirm tests fail (Red phase verification)
3. Confirm which tests are failing and why

### Update SPEC.md (Only After Tests Fail)

**Now** update SPEC.md:

1. Read the existing SPEC.md
2. Mark `[x]` next to Step 04 in SPEC.md
3. Do NOT copy test code into SPEC.md

### Final Verification

After updating SPEC.md, read it and confirm:
- [ ] SPEC.md Progress shows Step 04 as `[x]`
- [ ] SPEC.md does NOT contain any test code or spec content

### Report Results

Report:
- The exact test commands to run
- Which tests are failing and why (Red phase expected)
- Confirmation that tests fail before implementation

---

### Approval Confirmation

After marking Step 04 as `[x]` and updating `SPEC.md`, use **sldd-98-approval-helper** for the standardized completion and proceed prompt.
