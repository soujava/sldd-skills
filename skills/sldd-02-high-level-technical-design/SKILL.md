---
name: sldd-02-high-level-technical-design
description: Produce a high-level technical design with architecture diagram, component responsibilities, data flow, and test scenario map. Use after the product intent specification is approved.
metadata:
  step: "02"
  type: specification
---

# Skill: High-Level Technical Design

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

Step 02 requires **Step 01 to be complete and approved**.

1. **Verify Step 01 approval from available context:**
   - If a `SPEC.md` path is provided, read it and verify Step 01 is marked `[x]`.
   - Otherwise, if the approved Step 01 intent spec is explicitly provided in the prompt/context, treat that as the Step 01 input for this step.
   - If neither an approved Step 01 state nor an approved intent spec is available, stop for a gate violation.

2. **If violation detected:**
   → **STOP**. Reply in the user's language with this meaning:
> Cannot proceed to Step 02 because Step 01 is not marked complete/approved; restate gate sequence and request completion/approval of Step 01 first.

3. **If Step 01 approval is verified:** extract the approved Step 01 content as context and proceed with Step 02.

### Implementation Prohibition, Skip-Ahead Detection and Advisory

Step 02 may produce only design artifacts. Implementation actions are prohibited until Steps 01, 02 and 03 are all complete and approved.

If the user asks to "implement", "write code", "create tests", "start coding", "skip to tests", "just do it" at this stage:
→ **STOP**. Reply in the user's language that Steps 01, 02 and 03 must be completed and approved before any implementation can begin.

Pre-flight repository verification (advisory behavior):
- Perform a path-scoped `git status --porcelain` restricted to implementation paths (e.g. `src/main/`, `src/test/`). Ignore typical build/IDE folders by default.
- If uncommitted changes are detected, present a concise list to the user and request explicit typed acknowledgement to proceed despite the dirty working tree.
- In automated/non-interactive runs, enforce strict behavior: refuse to proceed if relevant implementation paths contain uncommitted changes.

Before writing any files, re-run the path-scoped git status and abort if anything changed.
---

## Context

You are a senior software architect translating the approved product intent into system design.

Intent spec: <provide the approved product intent specification>

SPEC.md (optional): <provide path to an existing SPEC.md to load prior context, or leave blank>

---

## SPEC.md Resume Behavior

If a SPEC.md path is provided:
1. Read the file and check the Progress checklist to identify which steps are already complete.
2. **VIOLATION CHECK:** If Step 02 is marked [x] but Step 01 is NOT marked [x] → this is a gate violation. Warn the user, refuse to continue from that state, and ask them to correct the SPEC progress first.
3. If Step 01 is marked complete, extract its section as the intent spec — no need to paste it manually.
4. If Step 99 is marked complete, include the codebase context as additional input.
5. Announce in the user's language that SLDD is resuming, list completed steps, and indicate continuation with Step 02.

If the user provides a specs root directory instead of a full path, list the available `SPEC.md` files under it and ask which feature to resume.

---

## Objective

Produce a high-level technical design that translates the product intent into architecture and system boundaries without implementation details or code.

**Audience:** Engineers, tech leads, and architects who will review this design and decide if it aligns with technical strategy and team capabilities.

**Style:** Text-based diagrams and structured sections. Visual representations in ASCII or text form are preferred (not code). Annotate relationships and data flows clearly.

**Tone:** Clear and architectural. Explain trade-offs between alternatives. Flag constraints or concerns early.

---

## Draft Output

**Present the following sections as a draft — do not save files yet.**
The user will review and approve before any files are written.

Deliver exactly these sections:
- Architecture diagram in text form (ASCII or text-based visualization)
- Component responsibilities (what each major component owns)
- Data flow (how data moves between components)
- Security and observability requirements (non-functional needs)
- Key trade-offs and alternatives considered (why this design, not another)
- High-level test scenario map (happy path, failure paths, and edge-case families)

Do not generate implementation code or tests. Do not write code in any language.

After presenting the draft, say in the user's language:
> Step 02 draft is ready for review; ask for approval or feedback before saving to file.

**Wait for user approval before proceeding to the save step.**

---

## Save Flow (only after user approval)

### ⚠️ CRITICAL: SPEC.md Structure Rule

**SPEC.md must contain ONLY the Progress checklist — never the step content itself.**

| File | Contents |
|------|----------|
| `SPEC.md` | Progress checklist + links only |
| `02-high-level-technical-design.md` | Step 02 content (six sections) |

---

### Save Steps

1. Ask in the user's language which directory should be used for specs (e.g. `docs/specs`)
2. Confirm the directory path from Step 01 (or ask if not resuming)
3. Create `<dir>/02-high-level-technical-design.md` with the six required sections.
4. Read the step file and verify that it contains exactly those six sections, does not include a `Progress` section, and does not duplicate content that belongs in other steps.
5. Read the existing `SPEC.md`, mark Step 02 as `[x]`, and link to `02-high-level-technical-design.md`.
6. Read `SPEC.md` and verify that it contains only the Progress checklist and links, not the Step 02 content itself.
7. If either verification fails, fix the files before continuing.

---

### Approval Confirmation

After marking Step 02 as `[x]` and updating `SPEC.md`, use **sldd-98-approval-helper** for the standardized completion and proceed prompt.

---

### Save Decision (Fallback)

First, check whether file writes are currently allowed:
- **If file writes are FORBIDDEN** (plan mode): tell the user in the user's language that plan mode cannot write files and they must switch to build/execution mode to save.
- **If file writes are ALLOWED and user approved:** ask in the user's language whether to save the spec output to a file (yes/no).
- **If no:** continue without saving. The draft is discarded.

If the user says yes, follow the save steps above whether `SPEC.md` already exists or not.
