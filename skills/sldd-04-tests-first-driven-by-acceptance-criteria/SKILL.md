---
name: sldd-04-tests-first-driven-by-acceptance-criteria
description: Write test files driven by acceptance criteria in strict TDD mode. No production code is generated. Use after the low-level design is approved.
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
4. If Step 99 is marked complete, include the codebase context (test framework, conventions) as additional input.
5. Announce: "Resuming SLDD process. Steps complete: [list]. Continuing with Step 04."
If the user provides a specs root directory instead of a full path, list all `*/SPEC.md` files found under it and ask which feature to resume.
If no SPEC.md is provided, proceed normally.

**Objective:**
Write test files that directly correspond to the acceptance criteria and test scenarios. These tests will drive implementation. Do not write production code yet.

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
- Brief comments for each test explaining what it validates
- Commands to run the test suite

Imperative: Write tests only. Do not write any production code. Do not implement any features. Your output is test files only.

**After delivering the output:**
Ask the user: "Save this output to SPEC.md? (yes/no)"
- If yes and no SPEC.md exists yet: ask "Which directory should I use for specs?" (e.g. `docs/specs`), then suggest a slug derived from the feature name and ask the user to confirm or edit it. Create `<dir>/<slug>/SPEC.md` with the Progress checklist header (all steps unchecked) and the Step 04 section (listing test files written and the commands to run them), marking Step 04 as `[x]`.
- If yes and a SPEC.md already exists: ask for the path to the existing SPEC.md, then append the `## Step 04 — Tests` section (listing test files written and run commands) and mark `[x]` next to Step 04 in the Progress checklist.
- If no: continue without saving.
