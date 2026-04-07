---
name: sldd-03-low-level-design-and-version-policy
description: Produce a detailed low-level design with API contracts, data models, error handling, test strategy, and dependency version policy. Use after the high-level design is approved.
metadata:
  step: "03"
  type: specification
---

# Skill: Low-Level Design and Version Policy

**Context:**
You are a staff engineer preparing an implementation plan. You have the high-level design and must now specify concrete interfaces, data models, and version constraints so implementation work can be precise and testable.

High-level design: <provide the approved high-level technical design>

SPEC.md (optional): <provide path to an existing SPEC.md to load prior context, or leave blank>

**SPEC.md resume behavior:**
If a SPEC.md path is provided:
1. Read the file and check the Progress checklist to identify which steps are already complete.
2. If Step 02 is marked complete, extract its section as the high-level design — no need to paste it manually.
3. If Step 01 is marked complete, extract it as additional intent context.
4. If Step 99 is marked complete, include the codebase context as additional input.
5. Announce: "Resuming SLDD process. Steps complete: [list]. Continuing with Step 03."
If the user provides a specs root directory instead of a full path, list all `*/SPEC.md` files found under it and ask which feature to resume.
If no SPEC.md is provided, proceed normally.

**Objective:**
Produce a detailed low-level design and implementation plan that specifies what to build, version constraints, and test strategy — enabling unambiguous work assignments.

**Audience:**
Implementation engineers, QA, and architects who need to know exactly what to build and verify, including which versions are acceptable.

**Style:**
Detailed and concrete. Specify interfaces, data models, and error handling explicitly. Include specific version and dependency requirements.

**Tone:**
Precise. No ambiguity about version policy or technical decisions. Flag any gaps or assumptions.

**Response:**
Deliver exactly these sections in this order:
- API contracts (endpoints, request/response schemas, error responses)
- Data models (database schema or core domain objects)
- Error model (what errors can occur and how to handle them)
- Test strategy (testing approach and scenarios)
- Test scenario catalog with edge cases (detailed testable scenarios, including boundaries, empty/large payloads, retries, concurrency, etc.)
- Dependency/version policy (which versions of which dependencies are acceptable)

Version policy requirements must include:
- Framework versions must be aligned with actively supported major versions
- Runtime versions must use a currently supported release line

After delivering the low-level design, produce a detailed ordered implementation plan listing every task (components, endpoints, data models, migrations, tests, configuration) as discrete sequenced steps small enough to evaluate individually. This plan is the checklist the team agrees on before any implementation prompt is sent.

Gate: present the high-level and low-level designs for review before any code is generated. Do not skip the review gate because AI can generate code quickly.

**After delivering the output:**
First, check whether file writes are currently allowed (i.e. whether you are NOT in plan mode / read-only mode):
- If file writes are FORBIDDEN (plan mode is active): tell the user explicitly — "I am in plan mode and cannot write files right now. To save this spec to SPEC.md, switch to build/execution mode and I will create it immediately." Do NOT ask the save question yet. Stop here.
- If file writes are ALLOWED: ask the user "Save this output to SPEC.md? (yes/no)"
- If yes and no SPEC.md exists yet: ask "Which directory should I use for specs?" (e.g. `docs/specs`), then suggest a slug derived from the feature name and ask the user to confirm or edit it. Create `<dir>/<slug>/SPEC.md` with the Progress checklist header (all steps unchecked) and the Step 03 section, marking Step 03 as `[x]`.
- If yes and a SPEC.md already exists: ask for the path to the existing SPEC.md, then append the `## Step 03 — Low-Level Design and Version Policy` section and mark `[x]` next to Step 03 in the Progress checklist.
- If no: continue without saving.
