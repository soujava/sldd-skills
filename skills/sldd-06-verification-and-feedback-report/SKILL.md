---
name: sldd-06-verification-and-feedback-report
description: Audit completed implementation against the spec and produce a gap report with compliance matrix, risks, remediation steps, and a go/no-go production readiness decision. Use after implementation is complete.
metadata:
  step: "06"
  type: verification
---

# Skill: Verification and Feedback Report

**Context:**
You are reviewing completed implementation against the low-level design spec. It is time to audit whether the work matches intent and identify gaps, risks, or compliance issues before release.

Spec: <provide the approved low-level design and product intent specification>

Implementation summary: <provide the implementation output or reference files>

SPEC.md (optional): <provide path to an existing SPEC.md to load prior context, or leave blank>

**SPEC.md resume behavior:**
If a SPEC.md path is provided:
1. Read the file and check the Progress checklist to identify which steps are already complete.
2. If Step 01 is marked complete, extract its section as the product intent spec (problem statement, acceptance criteria) — no need to paste it manually.
3. If Step 03 is marked complete, extract its section as the low-level design to audit against — no need to paste it manually.
4. If Step 05 is marked complete, extract the implementation summary (production files, run commands, assumptions) from its section — no need to provide it manually.
5. Announce: "Resuming SLDD process. Steps complete: [list]. Continuing with Step 06."
If the user provides a specs root directory instead of a full path, list all `*/SPEC.md` files found under it and ask which feature to resume.
If no SPEC.md is provided, proceed normally.

**Objective:**
Produce a gap report that compares the implementation against the spec and identifies what matches, what is missing, what risks remain, and whether the work is production-ready.

**Audience:**
Engineers, tech leads, QA, and release managers deciding whether this work is ready to merge and ship.

**Style:**
Structured report with matrices, lists, and clear status indicators (met/partial/missing). Prioritize risks by severity.

**Tone:**
Critical and honest. Flag every gap and risk. Provide actionable remediation steps. Give a clear yes/no on production readiness.

**Response:**
Before auditing, check whether an `AGENTS.md` file exists at the project root. If it references a testing guideline file, read it and use it as the baseline for test convention compliance checks.

Deliver exactly these sections in this order:
1) Compliance matrix (spec requirement → implementation status: met/partial/missing)
2) Version and dependency validation (are versions correct and supported?)
3) Test convention compliance: verify that test files follow the project's testing guideline (from `AGENTS.md` if present). Flag any tests that violate naming conventions, assertion style, soft assertion usage, AAA structure, or exception testing patterns.
4) Risk list by severity (high/medium/low)
5) Suggested remediation steps (how to fix gaps before release)
6) Decision: ready for production? yes/no and why. If no, list the top 3 blockers.

**After delivering the output:**
Ask the user: "Save this output to SPEC.md? (yes/no)"
- If yes and no SPEC.md exists yet: ask "Which directory should I use for specs?" (e.g. `docs/specs`), then suggest a slug derived from the feature name and ask the user to confirm or edit it. Create `<dir>/<slug>/SPEC.md` with the Progress checklist header (all steps unchecked) and the Step 06 section (full gap report and go/no-go decision), marking Step 06 as `[x]`.
- If yes and a SPEC.md already exists: ask for the path to the existing SPEC.md, then append the `## Step 06 — Verification Report` section (full gap report and go/no-go decision) and mark `[x]` next to Step 06 in the Progress checklist.
- If no: continue without saving.
