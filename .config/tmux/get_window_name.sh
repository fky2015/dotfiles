#!/usr/bin/env bash

# tmux 传递过来的当前 pane 的路径
PANE_PATH="$1"
# tmux 默认会显示的命令名
DEFAULT_CMD="$2"

# 切换到 pane 当前目录
cd "$PANE_PATH" 2>/dev/null || exit 0

# 检查是否在一个 git 目录中
if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    # 尝试获取分支名
    branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
    if [ -n "$branch" ]; then
        # 如果分支名包含 @ 字符，取最后一个 @ 之后的部分
        if [[ "$branch" == *"@"* ]]; then
            branch="${branch##*@}"
        fi
        # 截取分支名的前20个字符以防过长，并显示 git 图标和分支名
        echo "${branch:0:20}"
        exit 0
    fi
fi

# 如果不是 git 目录或者获取分支失败，返回默认命令
echo "$DEFAULT_CMD"
