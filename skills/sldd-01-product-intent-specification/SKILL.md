---
name: sldd-01-product-intent-specification
description: Produce a one-page product intent specification with problem statement, users, metrics, risks, and acceptance criteria in Given/When/Then format. Use before any technical design or implementation work begins. TRIGGERS when user asks to implement, refactor, write code, or make changes without an approved intent specification.
metadata:
  step: "01"
  type: specification
---

# Skill: Product Intent Specification

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

**BEFORE producing any spec output, check for violations:**

### Jump-Ahead Detection and Implementation Advisory

If the user explicitly asks to "implement", "refactor", "write code", "write tests", "just do it", "start coding", or similar at any point BEFORE Steps 01, 02 and 03 are all complete and approved:

→ **STOP**. Reply in the user's language with this meaning:
> Implementation is forbidden until Steps 01, 02 and 03 are completed and approved. Restate the gate sequence (Step 01 → Step 02 → Step 03 → Step 04 → Step 05) and ask whether the user wants to proceed with Step 01.

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
    - Ask in the user's language whether previous steps were completed and approved before proceeding, if implementation appears to have started. If the working tree is dirty, follow the advisory flow above (present files and request explicit typed acknowledgement) or refuse in automated mode.

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
2. **If Steps 02-06 are marked [x] but Step 01 is NOT marked [x], this is a GATE VIOLATION** — warn the user, refuse to continue from that state, and ask them to correct the SPEC progress before proceeding.
3. Otherwise, extract any existing section content to use as prior context.
4. Announce in the user's language that SLDD is resuming, list completed steps, and indicate continuation with Step 01.

If the user provides a specs root directory instead of a full path, list the available `SPEC.md` files under it and ask which feature to resume.

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

After presenting the draft, say in the user's language:
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

---

### Save Steps

1. Ask in the user's language which directory should be used for specs (e.g. `docs/specs`)
2. Suggest a slug derived from the feature (e.g. `add-user-auth`) and ask user to confirm or edit
3. Create `<dir>/<slug>/01-product-intent-specification.md` with the six required sections.
4. Read the step file and verify that it contains exactly those six sections, does not include a `Progress` section, and does not duplicate content that belongs in other steps.
5. Create or update `<dir>/<slug>/SPEC.md` with only the Progress checklist, mark Step 01 as `[x]`, and link to `01-product-intent-specification.md`.
6. Read `SPEC.md` and verify that it contains only the Progress checklist and link, not the Step 01 content itself.
7. If either verification fails, fix the files before continuing.

---

### Approval Confirmation

After marking Step 01 as `[x]` and updating `SPEC.md`, use **sldd-98-approval-helper** for the standardized completion and proceed prompt.

---

### Save Decision (Fallback)

First, check whether file writes are currently allowed:
- **If file writes are FORBIDDEN** (plan mode): tell the user in the user's language that plan mode cannot write files and they must switch to build/execution mode to save.
- **If file writes are ALLOWED and user approved:** ask in the user's language whether to save the spec output to a file (yes/no).
- **If no:** continue without saving. The draft is discarded.

If the user says yes, follow the save steps above whether `SPEC.md` is new or already exists.
