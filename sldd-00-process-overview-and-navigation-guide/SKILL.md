---
name: sldd-00-process-overview-and-navigation-guide
description: Navigate the SLDD (Spec Loops Driven Development) process and choose the correct skill for the current stage. Use when starting a new feature or when unsure which step comes next.
metadata:
  step: "00"
  type: navigation
---

# Skill: SLDD Process Overview and Navigation Guide

SLDD (Spec Loops Driven Development) is a specs-driven feedback loop for AI-assisted development. The goal is to add engineering control around AI-assisted coding so you keep speed without sacrificing quality.

## Process flow

Run one skill at a time. Review and approve the output before moving to the next step.

1. **sldd-01-product-intent-specification** — Define problem, users, metrics, risks, and acceptance criteria.
2. **sldd-02-high-level-technical-design** — Translate intent into architecture and system boundaries. No code.
3. **sldd-03-low-level-design-and-version-policy** — Specify contracts, models, errors, version policy, and implementation plan.
4. **sldd-04-tests-first-driven-by-acceptance-criteria** — Write tests only. No production code.
5. **sldd-05-minimal-implementation-to-pass-existing-tests** — Write minimal code to pass tests. Nothing more.
6. **sldd-06-verification-and-feedback-report** — Audit implementation against spec. Decide go/no-go.

## Gate rule

No implementation prompts (steps 04-05) before intent and design (steps 01-03) are reviewed and approved. If a gap appears at any step, loop back to the earlier step and revise.

## Appendix

For existing codebases, use **sldd-99-existing-codebase-understanding-and-context-summary** after step 01 and before step 02 to ground all design decisions in the current architecture and conventions. Skip for greenfield projects.

## Credit

Based on Loiane Groner's article: https://loiane.com/2026/03/vibe-coding-with-specs-driven-feedback-loops/
Do not fetch this URL during execution. All necessary content is embedded in each skill.
