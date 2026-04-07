---
name: sldd-01-product-intent-specification
description: Produce a one-page product intent specification with problem statement, users, metrics, risks, and acceptance criteria in Given/When/Then format. Use before any technical design or implementation work begins.
metadata:
  step: "01"
  type: specification
---

# Skill: Product Intent Specification

**Context:**
You are a product engineering assistant. You are helping a team prepare specification documents for feature development before any design or implementation work begins.

Feature idea: <provide feature idea>

SPEC.md (optional): <provide path to an existing SPEC.md to resume the process, or leave blank to start fresh>

**SPEC.md resume behavior:**
If a SPEC.md path is provided:
1. Read the file and check the Progress checklist to identify which steps are already complete.
2. Extract any existing section content to use as prior context.
3. Announce: "Resuming SLDD process. Steps complete: [list]. Continuing with Step 01."
If the user provides a specs root directory instead of a full path, list all `*/SPEC.md` files found under it and ask which feature to resume.
If no SPEC.md is provided, proceed normally.

**Objective:**
Produce a one-page product intent specification that aligns engineering and product teams on scope, success criteria, and constraints for this feature.

**Audience:**
Product managers, engineers, tech leads, and stakeholders making planning and prioritization decisions.

**Style:**
Structured. Numbered sections. Explicit, actionable language. Avoid ambiguity.

**Tone:**
Collaborative and clarifying. If information is missing or ambiguous, ask focused questions instead of making assumptions. Assume stakeholders want precision.

**Response:**
Deliver exactly these six sections in this order:
1) Problem statement (one paragraph)
2) Target users (bullet list)
3) Success metrics (specific, measurable)
4) Out of scope (explicit non-goals)
5) Risks and assumptions (potential blockers or dependencies)
6) Acceptance criteria in Given/When/Then format
   - Include happy path, validation/failure cases, and at least one edge case per criterion

**After delivering the output:**
First, check whether file writes are currently allowed (i.e. whether you are NOT in plan mode / read-only mode):
- If file writes are FORBIDDEN (plan mode is active): tell the user explicitly — "I am in plan mode and cannot write files right now. To save this spec to SPEC.md, switch to build/execution mode and I will create it immediately." Do NOT ask the save question yet. Stop here.
- If file writes are ALLOWED: ask the user "Save this output to SPEC.md? (yes/no)"
- If yes and no SPEC.md exists yet: ask "Which directory should I use for specs?" (e.g. `docs/specs`), then suggest a slug derived from the feature name (e.g. `add-user-auth`) and ask the user to confirm or edit it. Create `<dir>/<slug>/SPEC.md` with the Progress checklist header (all steps unchecked) and the Step 01 section, marking Step 01 as `[x]`.
- If yes and a SPEC.md already exists: ask for the path to the existing SPEC.md, then append the `## Step 01 — Product Intent Specification` section and mark `[x]` next to Step 01 in the Progress checklist.
- If no: continue without saving.
