# Go REST API + React Frontend

This workspace contains:
- `backend/`: Go + Gin REST API
- `frontend/`: React + Vite + TypeScript + Tailwind + shadcn/ui
- `agents/`: role-based AI agent prompts
- `scripts/`: helper scripts to run agent prompts

## Prerequisites

- Go `1.23+`
- Node.js `20+`
- `pnpm`
- `make`

Quick check:

```bash
go version
node -v
pnpm -v
make --version
```

---

## 1) Run Backend

Open a terminal in `backend/`:

```bash
cd backend
make deps
make tidy
make run
```

Backend default URL: `http://localhost:8080`

Available endpoints:
- `GET /users`
- `POST /users`

Quick test:

```bash
curl http://localhost:8080/users
```

---

## 2) Run Frontend

Open another terminal in `frontend/`:

```bash
cd frontend
pnpm install
pnpm dev
```

Frontend default URL: `http://localhost:5173`

Frontend uses Axios and calls:
- `VITE_API_BASE_URL` if set
- otherwise falls back to `http://localhost:8080`

Optional environment file (`frontend/.env`):

```env
VITE_API_BASE_URL=http://localhost:8080
```

---

## 3) Quality Checks

Backend:

```bash
cd backend
make check
```

`make check` runs:
- `go fmt ./...`
- `go vet ./...`
- `go test -v ./...`

Frontend:

```bash
cd frontend
pnpm lint
```

---

## 4) Build

Backend binary:

```bash
cd backend
make build
```

Output: `backend/bin/go-rest-api`

Frontend production build:

```bash
cd frontend
pnpm build
```

---

## 5) Delegate Work to Agents

Use role-based prompts in `agents/` via script:

```bash
./scripts/run-agent.sh <agent-name> "<task>"
```

Supported agent names:
- `project-manager` (`pm`)
- `business-analyst` (`ba`)
- `ui-ux-designer` (`ux`)
- `architecture-senior-dev` (`arch`)
- `frontend` (`fe`)
- `tester`
- `orchestrator`

### Recommended “work instead of me” flow

1. Start with orchestrator to generate the full delivery plan:

```bash
./scripts/run-agent.sh orchestrator "Plan and execute MVP for user management with Go backend and React frontend"
```

2. Run a specific specialist for implementation-ready output:

```bash
./scripts/run-agent.sh arch "Design backend modules, API contracts, and task breakdown for /users CRUD"
./scripts/run-agent.sh fe "Implement frontend pages and Axios integration for /users API"
./scripts/run-agent.sh tester "Create test plan, test cases, and quality gates for backend and frontend"
```

3. If your Codex CLI supports execution from prompt files, run in `--exec` mode:

```bash
./scripts/run-agent.sh orchestrator \
	"Execute full multi-agent delivery workflow for this repository" \
	--exec \
	--cmd 'codex exec --system-file {PROMPT_FILE} --input-file {TASK_FILE}'
```

This lets you hand over planning/analysis/design/testing tasks with minimal manual work.

---

## 6) Troubleshooting

### CORS errors (frontend -> backend)

- Ensure backend is running on port `8080`
- Ensure frontend runs from `localhost` or `127.0.0.1`
- Restart backend after CORS middleware updates

### Missing frontend packages

```bash
cd frontend
pnpm install
```

### Port already in use

```bash
cd frontend
pnpm dev -- --port 5174
```

---

## Project Structure

```text
go-rest-api/
├── backend/
├── frontend/
├── agents/
└── scripts/
```
