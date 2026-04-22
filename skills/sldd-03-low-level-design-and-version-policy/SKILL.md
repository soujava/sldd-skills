---
name: sldd-03-low-level-design-and-version-policy
description: Produce a detailed low-level design with API contracts, data models, error handling, test strategy, and dependency version policy. Use after the high-level design is approved.
metadata:
  step: "03"
  type: specification
---

# Skill: Low-Level Design and Version Policy

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

**Before producing any design output, verify prerequisites.**

### Prerequisite Check

Step 03 requires **Steps 01 and 02 to be complete and approved**.

1. **Verify Step 01 and Step 02 approval from available context:**
   - If a `SPEC.md` path is provided, read it and verify Steps 01 and 02 are marked `[x]`.
   - Otherwise, if approved Step 01 and Step 02 context is explicitly provided in the prompt/context, treat that as the prerequisite input for this step.
   - If neither an approved prior-step state nor approved prior-step context is available, stop for a gate violation.

2. **If violation detected:**
   → **STOP**. Reply in the user's language with this meaning:
> Cannot proceed to Step 03 because Steps 01 and/or 02 are not complete/approved; show status per prerequisite, restate gate rule, and request completion/approval first.

3. **If Steps 01 and 02 approval is verified:** extract the approved Step 01 and Step 02 content as context and proceed with Step 03.

### Implementation Gate, Skip-Ahead Detection and Advisory

Step 03 produces low-level design and version policy only. Implementation actions are forbidden until Step 03 is approved.

If the user asks to "implement", "write production code", "write tests", "just do it", or similar at this stage:
→ **STOP**. Reply in the user's language: Steps 01, 02 and 03 must be completed and approved before any implementation steps (Step 04/05) are permitted.

Pre-flight repository verification (advisory behavior):
- Perform a path-scoped `git status --porcelain` limited to implementation directories (e.g. `src/main/`, `src/test/`). Exclude conventional build/IDE directories by default.
- If there are uncommitted changes in relevant paths, present them concisely and require explicit typed acknowledgement from the user to proceed despite the dirty working tree.
- In automated/non-interactive modes, enforce strict behavior: refuse to perform file writes while relevant implementation paths contain uncommitted changes.

Re-check the working tree immediately before any file write and abort if new changes are detected.
---

## Context

You are a staff engineer preparing an implementation plan from the approved high-level design.

High-level design: <provide the approved high-level technical design>

SPEC.md (optional): <provide path to an existing SPEC.md to load prior context, or leave blank>

---

## SPEC.md Resume Behavior

If a SPEC.md path is provided:
1. Read the file and check the Progress checklist to identify which steps are already complete.
2. **VIOLATION CHECK:** If Step 03 is marked [x] but Step 01 or Step 02 is NOT marked [x] → this is a gate violation. Warn the user, refuse to continue from that state, and ask them to correct the SPEC progress first.
3. If Step 02 is marked complete, extract its section as the high-level design — no need to paste it manually.
4. If Step 01 is marked complete, extract it as additional intent context.
5. If Step 99 is marked complete, include the codebase context as additional input.
6. Announce in the user's language that SLDD is resuming, list completed steps, and indicate continuation with Step 03.

If the user provides a specs root directory instead of a full path, list the available `SPEC.md` files under it and ask which feature to resume.

---

## Objective

Produce a detailed low-level design and implementation plan that specifies what to build, version constraints, and test strategy, enabling unambiguous work assignments.

**Audience:** Implementation engineers, QA, and architects who need to know exactly what to build and verify, including which versions are acceptable.

**Style:** Detailed and concrete. Specify interfaces, data models, and error handling explicitly. Include specific version and dependency requirements.

**Tone:** Precise. No ambiguity about version policy or technical decisions. Flag any gaps or assumptions.

---

## Draft Output

**Present the following sections as a draft — do not save files yet.**
The user will review and approve before any files are written.

Deliver exactly these sections:
- API contracts (endpoints, request/response schemas, error responses)
- Data models (database schema or core domain objects)
- Error model (what errors can occur and how to handle them)
- Test strategy (testing approach and scenarios)
- Test scenario catalog with edge cases (detailed testable scenarios, including boundaries, empty/large payloads, retries, concurrency, etc.)
- Dependency/version policy (which versions of which dependencies are acceptable)

Version policy requirements must include:
- Framework versions must be aligned with actively supported major versions
- Runtime versions must use a currently supported release line

After delivering the low-level design, produce a detailed ordered implementation plan listing every task (components, endpoints, data models, migrations, tests, configuration) as discrete sequenced steps small enough to evaluate individually.

**Gate:** Present the high-level and low-level designs for review before any code is generated.

After presenting the draft, say in the user's language:
> Step 03 draft is ready for review; ask for approval or feedback before saving to file.

**Wait for user approval before proceeding to the save step.**

---

## Save Flow (only after user approval)

### ⚠️ CRITICAL: SPEC.md Structure Rule

**SPEC.md must contain ONLY the Progress checklist — never the step content itself.**

| File | Contents |
|------|----------|
| `SPEC.md` | Progress checklist + links only |
| `03-low-level-design-and-version-policy.md` | Step 03 content (six sections + implementation plan) |

---

### Save Steps

1. Confirm the directory path from previous steps (should be `docs/specs/<feature-slug>/`)
2. Create `<dir>/03-low-level-design-and-version-policy.md` with the required sections and implementation plan.
3. Read the step file and verify that it contains the required sections, does not include a `Progress` section, and does not duplicate content that belongs in other steps.
4. Read the existing `SPEC.md`, mark Step 03 as `[x]`, and link to `03-low-level-design-and-version-policy.md`.
5. Read `SPEC.md` and verify that it contains only the Progress checklist and links, not the Step 03 content itself.
6. If either verification fails, fix the files before continuing.

---

### Approval Confirmation

After marking Step 03 as `[x]` and updating `SPEC.md`, use **sldd-98-approval-helper** for the standardized completion and proceed prompt.

---

### Save Decision (Fallback)

First, check whether file writes are currently allowed:
- **If file writes are FORBIDDEN** (plan mode): tell the user in the user's language that plan mode cannot write files and they must switch to build/execution mode to save.
- **If file writes are ALLOWED and user approved:** ask in the user's language whether to save the spec output to a file (yes/no).
- **If no:** continue without saving. The draft is discarded.

If the user says yes, follow the save steps above whether `SPEC.md` already exists or not.
