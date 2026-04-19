---
name: sldd-04-tests-first-driven-by-acceptance-criteria
description: Write test files driven by acceptance criteria in strict TDD mode. Create only minimal stubs for compilation. Language-agnostic. Use after the low-level design is approved.
metadata:
  step: "04"
  type: implementation
---

# Skill: Tests First Driven by Acceptance Criteria

**Context:**
You are a senior engineer working in strict test-driven development (TDD) mode. You have a low-level design and acceptance criteria. Tests must be written first, before any production code.

Low-level design: <provide the approved low-level design>

Acceptance criteria: <provide the acceptance criteria from the product intent specification>

SPEC.md (optional): <provide path to an existing SPEC.md to load prior context, or leave blank>

**SPEC.md resume behavior:**
If a SPEC.md path is provided:
1. Read the file and check the Progress checklist to identify which steps are already complete.
2. If Step 03 is marked complete, extract its section as the low-level design — no need to paste it manually.
3. If Step 01 is marked complete, extract the acceptance criteria from its section — no need to paste them manually.
4. Announce: "Resuming SLDD process. Steps complete: [list]. Continuing with Step 04."
If the user provides a specs root directory instead of a full path, list all `*/SPEC.md` files found under it and ask which feature to resume.
If no SPEC.md is provided, proceed normally.

**Objective:**
Write ONLY test files. Create ZERO production code files. The tests will fail if the modules/functions/classes they reference do not exist — compile-time failures are a valid Red-phase outcome. Create ONLY the minimal stubs needed for tests to compile (or to produce meaningful compile errors that map to missing implementation):

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
TDD = Red (tests fail) → Green (minimal code passes) → Refactor. If you add business logic at Step 04, you skip the Red phase and defeat the feedback loop.

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

> A stub that passes a validation test has validation logic embedded. A stub that returns a correct value for a happy path has business logic embedded. Both violate Step 04.

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
- Tests compile (producing either compile-time or runtime failures)
- Compile-time failures (missing methods, undefined types) are valid Red-phase outcomes
- Runtime failures (assertions failing, "not implemented" errors) are also valid Red-phase outcomes
- A successful compilation with all tests passing is NOT the expected outcome at Step 04

**After delivering the output:**
First, check whether file writes are currently allowed (i.e. whether you are NOT in plan mode / read-only mode):
- If file writes are FORBIDDEN (plan mode is active): tell the user explicitly — "I am in plan mode and cannot write files right now. To save this spec output, switch to build/execution mode and I will create it immediately." Do NOT ask the save question yet. Stop here.
- If file writes are ALLOWED: ask the user "Update the SPEC.md? (yes/no)"

### Critical: Verify TDD Red Phase
After saving SPEC.md, run the tests. The Red phase is confirmed when tests do not all pass. Both compile-time failures (missing symbols, undefined types) and runtime failures (assertion errors, "not implemented" thrown) satisfy this definition of done. If the test suite compiles cleanly and all tests pass, you violated the stub rules — rollback and recreate stubs that expose the missing implementation. Step 04 must produce tests that fail in some form, not passing tests.