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

SPEC.md (optional): <provide path to an existing SPEC.md to load prior context, or leave blank>

**SPEC.md resume behavior:**
If a SPEC.md path is provided:
1. Read the file and check the Progress checklist to identify which steps are already complete.
2. If Step 03 is marked complete, extract its section as the low-level design — no need to paste it manually.
3. If Step 04 is marked complete, extract the test file locations and run commands from its section — no need to provide them manually.
4. If Step 99 is marked complete, include the codebase context (language, conventions, architecture) as additional input.
5. Announce: "Resuming SLDD process. Steps complete: [list]. Continuing with Step 05."
If the user provides a specs root directory instead of a full path, list all `*/SPEC.md` files found under it and ask which feature to resume.
If no SPEC.md is provided, proceed normally.

**Objective:**
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

**After delivering the output:**
First, check whether file writes are currently allowed (i.e. whether you are NOT in plan mode / read-only mode):
- If file writes are FORBIDDEN (plan mode is active): tell the user explicitly — "I am in plan mode and cannot write files right now. To save this spec output, switch to build/execution mode and I will create it immediately." Do NOT ask the save question yet. Stop here.
- If file writes are ALLOWED: ask the user "Save this spec output to SPEC.md and derived files? (yes/no)"
- If yes and no SPEC.md exists yet: ask "Which directory should I use for specs?" (e.g. `docs/specs`), then suggest a slug derived from the feature or module name (e.g. `add-user-auth`) and ask the user to confirm or edit it. Create `<dir>/<slug>/SPEC.md` with the Progress checklist header (all steps unchecked) 
- If yes and a SPEC.md already exists: update the existing file by marking Step 05 as complete.
- If no: continue without saving.