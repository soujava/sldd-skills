---
name: sldd-03-low-level-design-and-version-policy
description: Produce a detailed low-level design with API contracts, data models, error handling, test strategy, and dependency version policy. Use after the high-level design is approved.
metadata:
  step: "03"
  type: specification
---

# Skill: Low-Level Design and Version Policy

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

Step 03 requires **Steps 01 and 02 to be complete and approved**.

1. **Check SPEC.md Progress:**
   - Read the SPEC.md file
   - Verify Step 01 is marked `[x]` (Product Intent approved)
   - Verify Step 02 is marked `[x]` (High-Level Design approved)
   - If Step 01 or Step 02 is NOT marked `[x]` → **GATE VIOLATION**

2. **If violation detected:**
   → **STOP**. Reply in the resolved language with this meaning:
> Cannot proceed to Step 03 because Steps 01 and/or 02 are not complete/approved; show status per prerequisite, restate gate rule, and request completion/approval first.

3. **If Steps 01 and 02 are complete [x]:**
   - Extract Step 01 and Step 02 content as context
   - Proceed with Step 03

### Skip-Ahead Detection

If user asks to "implement", "write tests", "write code", "skip to tests", "just do it" at this stage:
→ **STOP**. Reply in the resolved language that Steps 01, 02, and 03 must be completed before tests or implementation.

---

## Context

You are a staff engineer preparing an implementation plan. You have the high-level design and must now specify concrete interfaces, data models, and version constraints so implementation work can be precise and testable.

High-level design: <provide the approved high-level technical design>

SPEC.md (optional): <provide path to an existing SPEC.md to load prior context, or leave blank>

---

## SPEC.md Resume Behavior

If a SPEC.md path is provided:
1. Read the file and check the Progress checklist to identify which steps are already complete.
2. **VIOLATION CHECK:** If Step 03 is marked [x] but Step 01 or Step 02 is NOT marked [x] → this is a gate violation. Warn the user.
3. If Step 02 is marked complete, extract its section as the high-level design — no need to paste it manually.
4. If Step 01 is marked complete, extract it as additional intent context.
5. If Step 99 is marked complete, include the codebase context as additional input.
6. Announce in the resolved language that SLDD is resuming, list completed steps, and indicate continuation with Step 03.

If the user provides a specs root directory instead of a full path, list all `*/SPEC.md` files found under it and ask which feature to resume.

---

## Objective

Produce a detailed low-level design and implementation plan that specifies what to build, version constraints, and test strategy — enabling unambiguous work assignments.

**Audience:** Implementation engineers, QA, and architects who need to know exactly what to build and verify, including which versions are acceptable.

**Style:** Detailed and concrete. Specify interfaces, data models, and error handling explicitly. Include specific version and dependency requirements.

**Tone:** Precise. No ambiguity about version policy or technical decisions. Flag any gaps or assumptions.

---

## Draft Output

**Present the following sections as a draft — this is NOT yet saved to any file.**
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

After presenting the draft, say in the resolved language:
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

**❌ WRONG — Do NOT do this:**
```markdown
# SPEC: My Feature
- [ ] Step 01
- [ ] Step 02
- [ ] Step 03
## API Contracts
...
## Data Models
...
```

**✅ CORRECT — Do THIS:**
```markdown
# SPEC: My Feature
## Progress
- [x] Step 01 — Product Intent Specification -> 01-product-intent-specification.md
- [x] Step 02 — High-Level Technical Design -> 02-high-level-technical-design.md
- [ ] Step 03 — Low-Level Design and Version Policy -> 03-low-level-design-and-version-policy.md
...
```

---

### Step 1: Create the Step File (First!)

**Create the numbered step file BEFORE touching SPEC.md.**

1. Confirm the directory path from previous steps (should be `docs/specs/<feature-slug>/`)
2. Create `<dir>/03-low-level-design-and-version-policy.md` with the sections
3. **STOP. Do NOT touch SPEC.md yet.**

### Step 2: Verify the Step File

Read the file you just created and verify:
- [ ] It contains the sections (API Contracts, Data Models, Error Model, Test Strategy, Test Scenario Catalog, Dependency/Version Policy)
- [ ] It does NOT contain a "Progress" section
- [ ] It does NOT duplicate content that belongs in other steps

If verification fails, fix the step file before proceeding.

### Step 3: Update SPEC.md (Only After Verification Passes)

**Now** update SPEC.md:

1. Read the existing SPEC.md
2. Mark `[x]` next to Step 03 and link to `03-low-level-design-and-version-policy.md`
3. **Do NOT copy the sections into SPEC.md**

### Step 4: Final Verification

After updating SPEC.md, read it and confirm:
- [ ] SPEC.md contains ONLY the Progress checklist (and any previously saved step content if resuming)
- [ ] SPEC.md does NOT contain the step content (API Contracts, Data Models, etc.)
- [ ] The Progress checklist shows Step 03 as `[x]` with a link

If verification fails, remove any incorrectly added content from SPEC.md.

---

### Approval Confirmation

After marking Step 03 as [x] and updating SPEC.md, present:

```
## ✅ Step 03 complete and saved to: <file>

**Progress updated:**
- [x] Step 01 — Product Intent Specification -> 01-product-intent-specification.md
- [x] Step 02 — High-Level Technical Design -> 02-high-level-technical-design.md
- [x] Step 03 — Low-Level Design and Version Policy -> 03-low-level-design-and-version-policy.md

---

**Proceed to the next step?**

- **Yes**: Reply "yes, continue to Step 04"  
- **No**: Reply "no, wait for instructions"  
- **Approve and continue**: Reply "approved, proceed to Step 04"
```

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
