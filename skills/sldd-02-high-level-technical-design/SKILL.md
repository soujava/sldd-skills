---
name: sldd-02-high-level-technical-design
description: Produce a high-level technical design with architecture diagram, component responsibilities, data flow, and test scenario map. Use after the product intent specification is approved.
metadata:
  step: "02"
  type: specification
---

# Skill: High-Level Technical Design

## Project Settings

At the start of this step, before any other action:

1. **Read `AGENTS.md`** at the project root.
2. **Look for the `## SLDD` section** and extract:
   - `language` — use this for all conversation output and generated file content.
   - `specs-dir` — use this as the root directory for all spec file paths.
3. **Resolve language with this precedence:**
   - If the user explicitly requests a language in the current interaction, use it immediately.
   - Otherwise, use `language` from `AGENTS.md`.
   - If no language is configured, ask once, use the answer, and persist it in `AGENTS.md`.
4. **If the `## SLDD` section is missing:** ask the user to run `sldd-00` first to configure project settings, or ask them directly (in the resolved language) for preferred language and specs directory.
5. **Apply these settings throughout this step** — all responses, drafts, questions, gate messages, and saved files must use the resolved language and specs directory.

### Language Compliance Check (mandatory before every reply)

Before sending any user-facing message, validate language compliance:
- The full response (including final review/approval prompts) must be in the resolved language.
- The pre-defined replies ("yes, continue", "no", "approved, proceed to Step X", etc.) must be translated to the resolved language.
- If this skill contains example text in another language, translate the meaning; do not copy that text literally.
- If any sentence is not in the resolved language, rewrite the response before sending.

---

## 🚨 GATE ENFORCEMENT (Read First)

**BEFORE producing any design output, verify prerequisites:**

### Prerequisite Check

Step 02 requires **Step 01 to be complete and approved**.

1. **Check SPEC.md Progress:**
   - Read the SPEC.md file
   - Verify Step 01 is marked `[x]`
   - If Step 01 is NOT marked `[x]` → **GATE VIOLATION**

2. **If violation detected:**
   → **STOP**. Reply in the resolved language with this meaning:
> Cannot proceed to Step 02 because Step 01 is not marked complete/approved; restate gate sequence and request completion/approval of Step 01 first.

3. **If Step 01 is complete [x]:**
   - Extract Step 01 content as context
   - Proceed with Step 02

### Skip-Ahead Detection

If user asks to "implement", "write code", "skip to tests", "just do it" at this stage:
→ **STOP**. Reply in the resolved language that Steps 01 and 02 must be completed before implementation.

---

## Context

You are a senior software architect designing solutions. You have reviewed the product intent spec and are now translating business requirements into system design.

Intent spec: <provide the approved product intent specification>

SPEC.md (optional): <provide path to an existing SPEC.md to load prior context, or leave blank>

---

## SPEC.md Resume Behavior

If a SPEC.md path is provided:
1. Read the file and check the Progress checklist to identify which steps are already complete.
2. **VIOLATION CHECK:** If Step 02 is marked [x] but Step 01 is NOT marked [x] → this is a gate violation. Warn the user.
3. If Step 01 is marked complete, extract its section as the intent spec — no need to paste it manually.
4. If Step 99 is marked complete, include the codebase context as additional input.
5. Announce in the resolved language that SLDD is resuming, list completed steps, and indicate continuation with Step 02.

If the user provides a specs root directory instead of a full path, list all `*/SPEC.md` files found under it and ask which feature to resume.

---

## Objective

Produce a high-level technical design that translates the product intent into architecture and system boundaries, without implementation details or code.

**Audience:** Engineers, tech leads, and architects who will review this design and decide if it aligns with technical strategy and team capabilities.

**Style:** Text-based diagrams and structured sections. Visual representations in ASCII or text form are preferred (not code). Annotate relationships and data flows clearly.

**Tone:** Clear and architectural. Explain trade-offs between alternatives. Flag constraints or concerns early.

---

## Draft Output

**Present the following sections as a draft — this is NOT yet saved to any file.**
The user will review and approve before any files are written.

Deliver exactly these sections:
- Architecture diagram in text form (ASCII or text-based visualization)
- Component responsibilities (what each major component owns)
- Data flow (how data moves between components)
- Security and observability requirements (non-functional needs)
- Key trade-offs and alternatives considered (why this design, not another)
- High-level test scenario map (happy path, failure paths, and edge-case families)

Do not generate implementation code or tests. Do not write code in any language.

After presenting the draft, say in the resolved language:
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

**❌ WRONG — Do NOT do this:**
```markdown
# SPEC: My Feature
- [ ] Step 01
- [ ] Step 02
## Architecture Diagram
...
## Component Responsibilities
...
```

**✅ CORRECT — Do THIS:**
```markdown
# SPEC: My Feature
## Progress
- [x] Step 01 — Product Intent Specification -> 01-product-intent-specification.md
- [ ] Step 02 — High-Level Technical Design -> 02-high-level-technical-design.md
...
```

---

### Step 1: Create the Step File (First!)

**Create the numbered step file BEFORE touching SPEC.md.**

1. Ask in the resolved language which directory should be used for specs (e.g. `docs/specs`)
2. Confirm the directory path from Step 01 (or ask if not resuming)
3. Create `<dir>/02-high-level-technical-design.md` with the six sections
4. **STOP. Do NOT touch SPEC.md yet.**

### Step 2: Verify the Step File

Read the file you just created and verify:
- [ ] It contains exactly the six sections (Architecture Diagram, Component Responsibilities, Data Flow, Security/Observability, Trade-offs, Test Scenario Map)
- [ ] It does NOT contain a "Progress" section
- [ ] It does NOT duplicate content that belongs in other steps

If verification fails, fix the step file before proceeding.

### Step 3: Update SPEC.md (Only After Verification Passes)

**Now** update SPEC.md:

1. Read the existing SPEC.md
2. Mark `[x]` next to Step 02 and link to `02-high-level-technical-design.md`
3. **Do NOT copy the six sections into SPEC.md**

### Step 4: Final Verification

After updating SPEC.md, read it and confirm:
- [ ] SPEC.md contains ONLY the Progress checklist (and any previously saved step content if resuming)
- [ ] SPEC.md does NOT contain the step content (Architecture Diagram, Component Responsibilities, etc.)
- [ ] The Progress checklist shows Step 02 as `[x]` with a link

If verification fails, remove any incorrectly added content from SPEC.md.

---

### Approval Confirmation

After marking Step 02 as [x] and updating SPEC.md, present:

```
## ✅ Step 02 complete and saved to: <file>

**Progress updated:**
- [x] Step 01 — Product Intent Specification -> 01-product-intent-specification.md
- [x] Step 02 — High-Level Technical Design -> 02-high-level-technical-design.md

---

**Proceed to the next step?**

- **Yes**: Reply "yes, continue to Step 03"  
- **No**: Reply "no, wait for instructions"  
- **Approve and continue**: Reply "approved, proceed to Step 03"
```

**THE PRE-DEFINED REPLIES ("yes, continue", "no", "approved, proceed to Step X", etc.) MUST BE TRANSLATED TO THE RESOLVED LANGUAGE.**

---

### Save Decision (Fallback)

First, check whether file writes are currently allowed:
- **If file writes are FORBIDDEN** (plan mode): tell the user in the resolved language that plan mode cannot write files and they must switch to build/execution mode to save.
- **If file writes are ALLOWED and user approved:** ask in the resolved language whether to save the spec output to a file (yes/no).
- **If no:** continue without saving. The draft is discarded.

### New SPEC.md (no existing spec)

If no SPEC.md exists yet and user says yes, follow the **4-step process above**.

### Existing SPEC.md

If a SPEC.md already exists and user says yes, follow the **4-step process above** (Steps 1-4 apply to both new and existing specs).
