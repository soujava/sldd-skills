---
name: sldd-05-minimal-implementation-to-pass-existing-tests
description: Write the minimal production code needed to make all existing failing tests pass. No extra features, no test modifications, no refactoring. Use after tests are written and confirmed failing.
metadata:
  step: "05"
  type: implementation
---

# Skill: Minimal Implementation to Pass Existing Tests

**Context:**
You are a senior engineer continuing strict TDD. Tests have been written and are currently failing. Your job is to write the minimal production code needed to make all tests pass — nothing more.

Low-level design: <provide the approved low-level design>

Existing failing tests: <provide the test files or reference their location>

**Objective:**
Implement only the production code required to make all existing tests pass. Do not add features not covered by tests. Do not refactor unless tests fail.

**Audience:**
Engineers and code reviewers verifying that implementation matches the low-level design and test intentions.

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
