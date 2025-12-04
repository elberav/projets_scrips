#!/usr/bin/env bash
# Theme: Arbax_723next V13 (Optimized - Instant Load)

# --- 1. Definición de Colores ---
C_RESET="\001\e[0m\002"
C_WHITE="\001\e[97m\002"
C_BLACK="\001\e[38;5;16m"
C_BLUE="\001\e[38;2;107;189;183m\002"
C_CYAN="\001\e[38;5;44m\002"
C_GREEN="\001\e[38;5;113m\002"
C_YELLOW="\001\e[38;5;178m\002"
C_RED="\001\e[38;5;203m\002"
C_GRAY_TXT="\001\e[38;5;250m\002"

# --- 2. Fondos ---
BG_MAIN="\001\e[48;5;236m\002"
BG_TOP="\001\e[48;5;236m\002"
BG_BLUE="\001\e[48;2;107;189;183m\002"

FG_COLOR_OF_MAIN="\001\e[38;5;236m\002"
FG_COLOR_OF_BLUE="\001\e[38;2;107;189;183m\002"

# --- 3. Iconos ---
ICON_OS=""
ICON_DIR=""
ICON_GIT=""
ICON_PY=""
ICON_CONDA=""
ICON_VENV_FOUND=""
ICON_K8S=""
ICON_NODE=""
ICON_DOCKER=""
ICON_TIME=""
SEP_ARROW=""
SEP_R=""
SEP_L=""
SEP_LINE=""

generate_ps1() {
    local EXIT_CODE=$?
    local TOP_CONTENT=""
    local HAS_CONTENT=0

    # --- A. GIT (Solo si estamos en un repo) ---
    # Usamos git status --porcelain que es mas rapido, y desviamos stderr
    if git rev-parse --is-inside-work-tree &>/dev/null; then
        local BRANCH=$(git symbolic-ref --short HEAD 2>/dev/null)
        # Ojo: --untracked-files=no acelera mucho en repos grandes
        local STATUS=$(git status --porcelain --untracked-files=no 2>/dev/null)

        local G_COLOR="$C_GREEN"
        local G_ICON=""
        if [[ -n "$STATUS" ]]; then
            G_COLOR="$C_YELLOW"
            G_ICON="*"
        fi
        TOP_CONTENT+="${G_COLOR}${ICON_GIT} ${BRANCH}${G_ICON}"
        HAS_CONTENT=1
    fi

    # --- B. ENTORNO PYTHON (Lógica pura de Bash, muy rápida) ---
    local ENV_TXT=""
    if [[ -n "$VIRTUAL_ENV" ]]; then
        ENV_TXT="${C_YELLOW}${ICON_PY} ${VIRTUAL_ENV##*/}"
    elif [[ -n "$CONDA_DEFAULT_ENV" ]]; then
        ENV_TXT="${C_GREEN}${ICON_CONDA} ${CONDA_DEFAULT_ENV}"
    else
        # Chequeo rápido de archivos
        if [[ -f "pyvenv.cfg" ]]; then
            ENV_TXT="${C_GRAY_TXT}${ICON_VENV_FOUND} ${PWD##*/} (off)"
        elif [[ -d ".venv" ]]; then
            ENV_TXT="${C_GRAY_TXT}${ICON_VENV_FOUND} .venv (off)"
        elif [[ -d "venv" ]]; then
            ENV_TXT="${C_GRAY_TXT}${ICON_VENV_FOUND} venv (off)"
        fi
    fi

    if [[ -n "$ENV_TXT" ]]; then
        [[ $HAS_CONTENT -eq 1 ]] && TOP_CONTENT+=" ${C_GRAY_TXT}${SEP_LINE} "
        TOP_CONTENT+="${ENV_TXT}"
        HAS_CONTENT=1
    fi

    # --- C. CONTEXTO NODE.JS (Optimización Crítica) ---
    # En lugar de llamar a 'node', leemos el package.json con grep (Casi instantáneo)
    if [[ -f "package.json" ]]; then
        # Extrae versión sin lanzar el runtime de node
        local N_VER=$(grep '"version":' package.json | head -1 | awk -F: '{ print $2 }' | sed 's/[", ]//g')
        [[ -z "$N_VER" ]] && N_VER="Proj"

        [[ $HAS_CONTENT -eq 1 ]] && TOP_CONTENT+=" ${C_GRAY_TXT}${SEP_LINE} "
        TOP_CONTENT+="${C_GREEN}${ICON_NODE} ${N_VER}"
        HAS_CONTENT=1
    fi

    # --- D. KUBERNETES (Optimizado) ---
    # Solo chequea si existe la config, evita llamar a kubectl si no hay config
    if [[ -f "$HOME/.kube/config" || -n "$KUBECONFIG" ]]; then
        # Intentamos leer la variable de entorno primero (más rápido)
        # Si no, llamamos a kubectl (costoso, pero inevitable para contexto real)
        if type kubectl &>/dev/null; then
             local K8S_CONTEXT=$(kubectl config current-context 2>/dev/null)
             if [[ -n "$K8S_CONTEXT" ]]; then
                 [[ $HAS_CONTENT -eq 1 ]] && TOP_CONTENT+=" ${C_GRAY_TXT}${SEP_LINE} "
                 # Simplificamos para velocidad: Solo contexto, quitamos namespace para no hacer 2 llamadas
                 TOP_CONTENT+="${C_CYAN}${ICON_K8S} ${K8S_CONTEXT}"
                 HAS_CONTENT=1
             fi
        fi
    fi

    # --- E. DOCKER (Optimización Extrema) ---
    # NUNCA uses 'docker ps' en el prompt. Es demasiado lento.
    # Solo mostramos el icono si hay un Dockerfile presente.
    if [[ -f "Dockerfile" || -f "docker-compose.yml" ]]; then
        [[ $HAS_CONTENT -eq 1 ]] && TOP_CONTENT+=" ${C_GRAY_TXT}${SEP_LINE} "
        TOP_CONTENT+="${C_BLUE}${ICON_DOCKER}"
        HAS_CONTENT=1
    fi

    # --- F. HORA (Bash Built-in, instantáneo) ---
    printf -v TIME_VAL "%(%H:%M:%S)T" -1
    [[ $HAS_CONTENT -eq 1 ]] && TOP_CONTENT+=" ${C_GRAY_TXT}${SEP_LINE} "
    TOP_CONTENT+="${C_WHITE}${ICON_TIME} ${TIME_VAL}"

    # === [ARMADO FINAL] ===
    local TERM_COLS=${COLUMNS:-$(tput cols)}
    local CURRENT_PATH="${PWD/#$HOME/~}"
    # Recorte inteligente de ruta
    [[ ${#CURRENT_PATH} -gt $(( TERM_COLS / 2 )) ]] && PROMPT_DIRTRIM=3 || PROMPT_DIRTRIM=0

    PS1="\n${FG_COLOR_OF_MAIN}${SEP_L}${BG_TOP} ${TOP_CONTENT} ${C_RESET}${BG_TOP}${C_RESET}${FG_COLOR_OF_MAIN}${SEP_R}${C_RESET}\n"
    PS1+="${FG_COLOR_OF_BLUE}${SEP_L}${BG_BLUE}${C_BLACK} ${ICON_OS} \u ${C_BLUE}${BG_MAIN}${SEP_ARROW}${BG_MAIN} ${C_CYAN}${ICON_DIR} ${C_WHITE} \w ${C_RESET}${BG_MAIN}${C_RESET}${FG_COLOR_OF_MAIN}${SEP_R}${C_RESET}"

    local PROMPT_COLOR="$C_GREEN"
    [[ $EXIT_CODE -ne 0 ]] && PROMPT_COLOR="$C_RED"
    PS1+="\n${PROMPT_COLOR}➜ ${C_RESET}"
}

shopt -s checkwinsize
PROMPT_COMMAND=generate_ps1
