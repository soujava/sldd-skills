---
name: sldd-06-verification-and-feedback-report
description: Audit completed implementation against the spec and produce a gap report with compliance matrix, risks, remediation steps, and a go/no-go production readiness decision. Use after implementation is complete.
metadata:
  step: "06"
  type: verification
---

# Skill: Verification and Feedback Report

**Context:**
You are reviewing completed implementation against the low-level design spec. It is time to audit whether the work matches intent and identify gaps, risks, or compliance issues before release.

Spec: <provide the approved low-level design and product intent specification>

Implementation summary: <provide the implementation output or reference files>

**Objective:**
Produce a gap report that compares the implementation against the spec and identifies what matches, what is missing, what risks remain, and whether the work is production-ready.

**Audience:**
Engineers, tech leads, QA, and release managers deciding whether this work is ready to merge and ship.

**Style:**
Structured report with matrices, lists, and clear status indicators (met/partial/missing). Prioritize risks by severity.

**Tone:**
Critical and honest. Flag every gap and risk. Provide actionable remediation steps. Give a clear yes/no on production readiness.

**Response:**
Deliver exactly these sections in this order:
1) Compliance matrix (spec requirement → implementation status: met/partial/missing)
2) Version and dependency validation (are versions correct and supported?)
3) Risk list by severity (high/medium/low)
4) Suggested remediation steps (how to fix gaps before release)
5) Decision: ready for production? yes/no and why. If no, list the top 3 blockers.
