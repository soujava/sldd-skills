---
name: sldd-02-high-level-technical-design
description: Produce a high-level technical design with architecture diagram, component responsibilities, data flow, and test scenario map. Use after the product intent specification is approved.
metadata:
  step: "02"
  type: specification
---

# Skill: High-Level Technical Design

**Context:**
You are a senior software architect designing solutions. You have reviewed the product intent spec and are now translating business requirements into system design.

Intent spec: <provide the approved product intent specification>

SPEC.md (optional): <provide path to an existing SPEC.md to load prior context, or leave blank>

**SPEC.md resume behavior:**
If a SPEC.md path is provided:
1. Read the file and check the Progress checklist to identify which steps are already complete.
2. If Step 01 is marked complete, extract its section as the intent spec — no need to paste it manually.
3. If Step 99 is marked complete, include the codebase context as additional input.
4. Announce: "Resuming SLDD process. Steps complete: [list]. Continuing with Step 02."
If the user provides a specs root directory instead of a full path, list all `*/SPEC.md` files found under it and ask which feature to resume.
If no SPEC.md is provided, proceed normally.

**Objective:**
Produce a high-level technical design that translates the product intent into architecture and system boundaries, without implementation details or code.

**Audience:**
Engineers, tech leads, and architects who will review this design and decide if it aligns with technical strategy and team capabilities.

**Style:**
Text-based diagrams and structured sections. Visual representations in ASCII or text form are preferred (not code). Annotate relationships and data flows clearly.

**Tone:**
Clear and architectural. Explain trade-offs between alternatives. Flag constraints or concerns early.

**Response:**
Deliver exactly these sections in this order:
- Architecture diagram in text form (ASCII or text-based visualization)
- Component responsibilities (what each major component owns)
- Data flow (how data moves between components)
- Security and observability requirements (non-functional needs)
- Key trade-offs and alternatives considered (why this design, not another)
- High-level test scenario map (happy path, failure paths, and edge-case families)

Do not generate implementation code or tests. Do not write code in any language.

**After delivering the output:**
First, check whether file writes are currently allowed (i.e. whether you are NOT in plan mode / read-only mode):
- If file writes are FORBIDDEN (plan mode is active): tell the user explicitly — "I am in plan mode and cannot write files right now. To save this spec to SPEC.md, switch to build/execution mode and I will create it immediately." Do NOT ask the save question yet. Stop here.
- If file writes are ALLOWED: ask the user "Save this output to SPEC.md? (yes/no)"
- If yes and no SPEC.md exists yet: ask "Which directory should I use for specs?" (e.g. `docs/specs`), then suggest a slug derived from the feature name and ask the user to confirm or edit it. Create `<dir>/<slug>/SPEC.md` with the Progress checklist header (all steps unchecked) and the Step 02 section, marking Step 02 as `[x]`.
- If yes and a SPEC.md already exists: ask for the path to the existing SPEC.md, then append the `## Step 02 — High-Level Technical Design` section and mark `[x]` next to Step 02 in the Progress checklist.
- If no: continue without saving.
