---
name: sldd-01-product-intent-specification
description: Produce a one-page product intent specification with problem statement, users, metrics, risks, and acceptance criteria in Given/When/Then format. Use before any technical design or implementation work begins. TRIGGERS when user asks to implement, refactor, write code, or make changes without an approved intent specification.
metadata:
  step: "01"
  type: specification
---

# Skill: Product Intent Specification

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
- All the pre-defined replies  must be translated to the resolved language.
- If this skill contains example text in another language, translate the meaning; do not copy that text literally.
- If any sentence is not in the resolved language, rewrite the response before sending.

---

## 🚨 GATE ENFORCEMENT (Read First)

**BEFORE producing any spec output, check for violations:**

### Jump-Ahead Detection and Implementation Advisory

If the user explicitly asks to "implement", "refactor", "write code", "write tests", "just do it", "start coding", or similar at any point BEFORE Steps 01, 02 and 03 are all complete and approved:

→ **STOP**. Reply in the resolved language with this meaning:
> Implementation is forbidden until Steps 01, 02 and 03 are completed and approved. Restate the gate sequence (Step 01 → Step 02 → Step 03 → Step 04 → Step 05) and ask whether the user wants to proceed with Step 02.

Implementation Advisory (interactive mode):
- By default, perform a path-scoped repository check to surface any uncommitted changes that may affect implementation. Target relevant paths only (for example: `src/main/`, `src/test/`, or other project-specific implementation directories). Ignore build and IDE folders by default (e.g. `target/`, `build/`, `.idea/`, `.vscode/`).
- Run `git status --porcelain` scoped to the relevant paths and present a concise list of modified files to the user. Do NOT modify files.
- Ask the user for explicit consent to proceed despite a dirty working tree. Require a typed acknowledgement (for auditability). For example, ask the user to reply with the exact phrase: `I acknowledge and accept the dirty working tree` to proceed.

Strict behavior (automated / non-interactive mode):
- If the agent is running in an automated or non-interactive environment (CI, scheduled runs, or when the user asked the agent to auto-commit), enforce a strict rule: refuse to perform any file writes or code generation while relevant implementation paths contain uncommitted changes. Require the working tree to be clean.

Pre-flight checks and TOCTOU mitigation:
- Always re-check the working tree immediately before any file write. If new changes appear between checks, abort and surface the new diffs to the user, requiring re-acknowledgement.

### Pre-Flight Check (when starting Step 01 fresh)

If no SPEC.md exists and user asks to start Step 01:

1. **Check for existing implementation:**
   - Run a path-scoped `git status --porcelain` (or equivalent) to detect uncommitted changes in implementation directories.
   - If there are modified implementation files (not docs/tests), the user may be skipping ahead.
    - Ask in the resolved language whether previous steps were completed and approved before proceeding, if implementation appears to have started. If the working tree is dirty, follow the advisory flow above (present files and request explicit typed acknowledgement) or refuse in automated mode.

2. **Check for existing SPEC.md in docs/specs/:**
   - If a SPEC.md exists with Steps 02-06 marked [x] but Step 01 was never reviewed, this is a violation — warn the user
### Approval Gate

**CRITICAL:** Step 01 is not complete until:
- [ ] Draft spec output is produced and presented to the user
- [ ] **User explicitly approves** ("looks good", "approved", "proceed to Step 02")

Do NOT mark Step 01 as [x] or proceed to Step 02 without user approval.

---

## Context

You are a product engineering assistant. You are helping a team prepare specification documents for feature development before any design or implementation work begins.

Feature idea: <provide feature idea>

SPEC.md (optional): <provide path to an existing SPEC.md to resume the process, or leave blank to start fresh>

---

## SPEC.md Resume Behavior

If a SPEC.md path is provided:
1. Read the file and check the Progress checklist to identify which steps are already complete.
2. **If Steps 02-06 are marked [x] but Step 01 is NOT marked [x], this is a GATE VIOLATION** — warn the user before proceeding.
3. Extract any existing section content to use as prior context.
4. Announce in the resolved language that SLDD is resuming, list completed steps, and indicate continuation with Step 01.

If the user provides a specs root directory instead of a full path, list all `*/SPEC.md` files found under it and ask which feature to resume.

If no SPEC.md is provided, proceed with the pre-flight checks above.

---

## Objective

Produce a one-page product intent specification that aligns engineering and product teams on scope, success criteria, and constraints for this feature.

**Audience:** Product managers, engineers, tech leads, and stakeholders making planning and prioritization decisions.

**Style:** Structured. Numbered sections. Explicit, actionable language. Avoid ambiguity.

**Tone:** Collaborative and clarifying. If information is missing or ambiguous, ask focused questions instead of making assumptions. Assume stakeholders want precision.

---

## Draft Output

**Present the following six sections as a draft — this is NOT yet saved to any file.**
The user will review and approve before any files are written.

Deliver exactly these six sections:

1) Problem statement (one paragraph)
2) Target users (bullet list)
3) Success metrics (specific, measurable)
4) Out of scope (explicit non-goals)
5) Risks and assumptions (potential blockers or dependencies)
6) Acceptance criteria in Given/When/Then format
   - Include happy path, validation/failure cases, and at least one edge case per criterion

After presenting the draft, say in the resolved language:
> Step 01 draft is ready for review; ask for approval or feedback before saving to file.

**Wait for user approval before proceeding to the save step.**

---

## Save Flow (only after user approval)

### ⚠️ CRITICAL: SPEC.md Structure Rule

**SPEC.md must contain ONLY the Progress checklist — never the step content itself.**

| File | Contents |
|------|----------|
| `SPEC.md` | Progress checklist + links only |
| `01-product-intent-specification.md` | Step 01 content (six sections) |

**❌ WRONG — Do NOT do this:**
```markdown
# SPEC: My Feature
- [ ] Step 01
## 1. Problem Statement
...
## 2. Target Users
...
```

**✅ CORRECT — Do THIS:**
```markdown
# SPEC: My Feature
## Progress
- [ ] Step 01 — Product Intent Specification -> 01-product-intent-specification.md
- [ ] Step 02 — High-Level Technical Design
...
```

---

### Step 1: Create the Step File (First!)

**Create the numbered step file BEFORE touching SPEC.md.**

1. Ask in the resolved language which directory should be used for specs (e.g. `docs/specs`)
2. Suggest a slug derived from the feature (e.g. `add-user-auth`) and ask user to confirm or edit
3. Create `<dir>/<slug>/01-product-intent-specification.md` with the six sections
4. **STOP. Do NOT touch SPEC.md yet.**

### Step 2: Verify the Step File

Read the file you just created and verify:
- [ ] It contains exactly the six sections (Problem Statement, Target Users, Success Metrics, Out of Scope, Risks and Assumptions, Acceptance Criteria)
- [ ] It does NOT contain a "Progress" section
- [ ] It does NOT duplicate content that belongs in other steps

If verification fails, fix the step file before proceeding.

### Step 3: Update SPEC.md (Only After Verification Passes)

**Now** update SPEC.md:

1. Create `<dir>/<slug>/SPEC.md` with only the Progress checklist (all steps unchecked)
2. Mark `[x]` next to Step 01 and link to `01-product-intent-specification.md`
3. **Do NOT copy the six sections into SPEC.md**

### Step 4: Final Verification

After updating SPEC.md, read it and confirm:
- [ ] SPEC.md contains ONLY the Progress checklist
- [ ] SPEC.md does NOT contain the step content (Problem Statement, Target Users, etc.)
- [ ] The Progress checklist shows Step 01 as `[x]` with a link

If verification fails, remove any incorrectly added content from SPEC.md.

---

### Approval Confirmation

After marking Step 01 as [x] and updating SPEC.md, present:

```
## ✅ Step 01 complete and saved to: <file>

**Progress updated:**
- [x] Step 01 — Product Intent Specification -> 01-product-intent-specification.md

---

**Proceed to the next step?**

- **Yes**: Reply "yes, continue to Step 02"  
- **No**: Reply "no, wait for instructions"  
- **Approve and continue**: Reply "approved, proceed to Step 02"
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
