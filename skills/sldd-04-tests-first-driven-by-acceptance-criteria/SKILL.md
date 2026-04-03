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

**Objective:**
Write test files that directly correspond to the acceptance criteria and test scenarios. These tests will drive implementation. Do not write production code yet.

**Audience:**
Engineers who will run these tests immediately and implement code to make them pass.

**Style:**
Test code in the project's native test framework. One test per clearly named scenario. Include brief comments explaining what each test validates.

**Tone:**
Explicit. Each test must map to one acceptance criterion. Leave no ambiguity about what passes or fails.

**Response:**
Deliver:
- Test files (write actual test code using the project's test framework)
- One test per acceptance criterion, plus at least one edge case test per criterion
- Brief comments for each test explaining what it validates
- Commands to run the test suite

Imperative: Write tests only. Do not write any production code. Do not implement any features. Your output is test files only.
