# Multi-Agent Prompts for Codex

This folder contains role-based prompt files for running workflows with Codex:

- `project-manager.md`
- `business-analyst.md`
- `ui-ux-designer.md`
- `frontend.md`
- `architecture-senior-dev.md`
- `tester.md`
- `orchestrator.md` (coordinates the full workflow)

## Quick Start

### 1) Print a prompt to terminal

```bash
./scripts/run-agent.sh project-manager "Plan an MVP roadmap for a Go REST API task manager"
```

### 2) Run directly with Codex (recommended)

Because Codex CLI syntax may vary by version, the script supports a command template:

```bash
./scripts/run-agent.sh architecture-senior-dev \
  "Design architecture for task CRUD + JWT auth" \
  --exec \
  --cmd 'codex exec --system-file {PROMPT_FILE} --input-file {TASK_FILE}'
```

The script will replace:

- `{PROMPT_FILE}`: merged prompt file (role + context + task)
- `{TASK_FILE}`: plain task-only file

## Valid Agent Names

- `project-manager` (`pm`)
- `business-analyst` (`ba`)
- `ui-ux-designer` (`ux`)
- `frontend` (`fe`)
- `architecture-senior-dev` (`arch`)
- `tester`
- `orchestrator`

## Recommended Workflow

1. `project-manager` -> create timeline and deliverables
2. `business-analyst` -> define and structure requirements
3. `ui-ux-designer` -> produce user flow and API-facing UX notes
4. `architecture-senior-dev` -> create backend technical design and API contracts
5. `frontend` -> plan/implement React + TypeScript + Vite + shadcn/ui frontend
6. `tester` -> create test plan, test cases, and quality gates
