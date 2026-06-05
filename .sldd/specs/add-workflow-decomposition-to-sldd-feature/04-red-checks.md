# Step 04 Red Checks

These checks are executable repository assertions for the workflow decomposition feature.

They intentionally fail before Step 05 because workflow-set support has not been added yet.

## Commands

```bash
test -f skills/sldd/steps/01-workflow-set-plan.md
test -f skills/sldd/steps/02-scaffold-children.md
test -f skills/sldd/steps/03-verify-workflow-set.md
test -f skills/sldd/templates/01-workflow-set-plan.md
test -f skills/sldd/templates/01-product-intent-from-workflow-set.md
grep -q 'workflow-set' skills/sldd/SKILL.md
grep -q 'Missing kind means feature' skills/sldd/SKILL.md
grep -q 'workflowSet' skills/sldd/schema/_spec-journal.schema.json
grep -q 'origin' skills/sldd/schema/_spec-journal.schema.json
grep -q 'workflow-set' README.md
```

## Acceptance Criteria Mapping

- Workflow-set step files exist.
- Workflow-set templates exist.
- Router documentation recognizes `workflow-set`.
- Router documentation rejects journals without required `name` and `kind`.
- Journal schema supports workflow-set and scaffold origin metadata.
- User-facing README documents workflow decomposition.
