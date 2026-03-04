#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
AGENT_DIR="$ROOT_DIR/agents"

usage() {
  cat <<'EOF'
Usage:
  ./scripts/run-agent.sh <agent-name> "<task>" [--exec] [--cmd '<command-template>']

Agents:
  project-manager | pm
  business-analyst | ba
  ui-ux-designer | ux
  frontend | fe
  architecture-senior-dev | arch
  tester
  orchestrator

Options:
  --exec                  Execute command template.
  --cmd '<template>'      Command template with placeholders:
                          {PROMPT_FILE} and {TASK_FILE}

Example:
  ./scripts/run-agent.sh pm "Lập kế hoạch MVP cho API tasks"

  ./scripts/run-agent.sh arch "Thiết kế module auth JWT" --exec \
    --cmd 'codex exec --system-file {PROMPT_FILE} --input-file {TASK_FILE}'
EOF
}

if [[ $# -lt 2 ]]; then
  usage
  exit 1
fi

agent_input="$1"
task="$2"
shift 2

exec_mode="false"
cmd_template=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --exec)
      exec_mode="true"
      shift
      ;;
    --cmd)
      if [[ $# -lt 2 ]]; then
        echo "Missing value for --cmd"
        exit 1
      fi
      cmd_template="$2"
      shift 2
      ;;
    *)
      echo "Unknown option: $1"
      usage
      exit 1
      ;;
  esac
done

resolve_agent_file() {
  case "$1" in
    project-manager|pm) echo "$AGENT_DIR/project-manager.md" ;;
    business-analyst|ba|bunsiness-analysist) echo "$AGENT_DIR/business-analyst.md" ;;
    ui-ux-designer|ux) echo "$AGENT_DIR/ui-ux-designer.md" ;;
    frontend|fe) echo "$AGENT_DIR/frontend.md" ;;
    architecture-senior-dev|arch) echo "$AGENT_DIR/architecture-senior-dev.md" ;;
    tester) echo "$AGENT_DIR/tester.md" ;;
    orchestrator) echo "$AGENT_DIR/orchestrator.md" ;;
    *)
      echo "Unsupported agent: $1"
      usage
      exit 1
      ;;
  esac
}

agent_file="$(resolve_agent_file "$agent_input")"

if [[ ! -f "$agent_file" ]]; then
  echo "Agent prompt file not found: $agent_file"
  exit 1
fi

prompt_file="$(mktemp "${TMPDIR:-/tmp}/agent-prompt.XXXXXX.txt")"
task_file="$(mktemp "${TMPDIR:-/tmp}/agent-task.XXXXXX.txt")"

cat > "$prompt_file" <<EOF
$(cat "$agent_file")

Project context:
- Backend: Go REST API
- Frontend: ReactJS + TypeScript + Vite + Tailwind + shadcn/ui
- Workspace: $ROOT_DIR

Task:
$task
EOF

printf "%s\n" "$task" > "$task_file"

if [[ "$exec_mode" == "true" ]]; then
  if [[ -z "$cmd_template" ]]; then
    echo "--exec requires --cmd '<command-template>'"
    exit 1
  fi

  command_to_run="${cmd_template//\{PROMPT_FILE\}/$prompt_file}"
  command_to_run="${command_to_run//\{TASK_FILE\}/$task_file}"

  echo "Executing command template..."
  eval "$command_to_run"
else
  cat "$prompt_file"
fi
