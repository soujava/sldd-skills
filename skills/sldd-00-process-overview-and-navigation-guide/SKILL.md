---
name: sldd-00-process-overview-and-navigation-guide
description: Start/resume SLDD, validate checklist consistency, and route to the next valid step.
metadata:
  step: "00"
  type: navigation
---

# Skill: SLDD Process Overview and Navigation Guide

Use `sldd-88-shared-templates-and-protocols` for gate rules, artifact paths, and save protocol.

## Objective

Determine current state, block invalid jumps, and route to one valid next step.

## Gate Order

Step 01 -> Step 99 (existing codebases only) -> Step 02 -> Step 03 -> Step 04 -> Step 05 -> Step 06

## Start/Resume Flow

1. Detect jump-ahead requests and stop if prerequisites are missing.
2. Resolve target `SPEC.md`:
   - user-provided path, or
   - selected file under provided specs root, or
   - default `docs/specs/<feature-name>/SPEC.md`.
3. Read checklist and detect out-of-order completions.
4. If violation exists, stop and route to missing step.
5. Route only to the next valid step skill.

## Response Format

1. Completed steps
2. Violations (if any)
3. Next required step + reason
4. Prompt for confirmation to continue

## Credit

Based on Loiane Groner's article: https://loiane.com/2026/03/vibe-coding-with-specs-driven-feedback-loops/

Do not fetch this URL during execution. All necessary content is embedded in each skill.
