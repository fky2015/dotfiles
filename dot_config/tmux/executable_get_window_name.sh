#!/usr/bin/env bash

# tmux 传递过来的当前 pane 的路径
PANE_PATH="${1:-}"
# tmux 默认会显示的命令名
DEFAULT_CMD="${2:-}"
MAX_LEN=20

fallback_name() {
    # 有些 tmux/进程状态下 #{pane_current_command} 可能是空或 "-"，
    # 此时用当前目录名兜底，避免窗口名显示成空或 "-"。
    if [[ -n "$DEFAULT_CMD" && "$DEFAULT_CMD" != "-" ]]; then
        printf '%s\n' "$DEFAULT_CMD"
        return
    fi

    if [[ -n "$PANE_PATH" ]]; then
        basename -- "$PANE_PATH"
        return
    fi

    printf 'tmux\n'
}

# 切换到 pane 当前目录；失败时返回一个可用的兜底名称
cd "$PANE_PATH" 2>/dev/null || {
    fallback_name
    exit 0
}

# 尽量少调用 git。正常分支使用 symbolic-ref；detached HEAD 时显示短 commit。
branch=$(git symbolic-ref --quiet --short HEAD 2>/dev/null)
if [[ -z "$branch" ]]; then
    commit=$(git rev-parse --short HEAD 2>/dev/null)
    if [[ -n "$commit" ]]; then
        branch="detached:$commit"
    fi
fi

if [[ -n "$branch" ]]; then
    # 如果分支名包含 @ 字符，取最后一个 @ 之后的部分。
    # 这是为了适配形如 user@branch 的分支命名。
    if [[ "$branch" == *"@"* ]]; then
        branch="${branch##*@}"
    fi

    printf '%s\n' "${branch:0:$MAX_LEN}"
    exit 0
fi

# 如果不是 git 目录或者获取分支失败，返回默认命令/目录名兜底
fallback_name
