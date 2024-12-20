#!/usr/bin/env bash

ENTER="
"
SEPARADOR_PROMPT=""
P_COLOR_1=blue
P_COLOR_2=cyan
P_COLOR_3=bright_black
P_1="[black on ${P_COLOR_1}]${SEPARADOR_PROMPT}[/]"
P_2="[bright_white on ${P_COLOR_1}] $(date -I) [/]"
P_3="[${P_COLOR_1} on ${P_COLOR_2}]${SEPARADOR_PROMPT}[/]"
P_4="[white on ${P_COLOR_2}] $(whoami)@$(cat /proc/sys/kernel/hostname) [/]"
P_5="[${P_COLOR_2} on ${P_COLOR_3}]${SEPARADOR_PROMPT}[/]"
P_6="[bright_white on ${P_COLOR_3}] $(pwd) [/]"
P_7="[${P_COLOR_3}]${SEPARADOR_PROMPT}[/]"
PROMPT="${P_1}${P_2}${P_3}${P_4}${P_5}${P_6}${P_7}"


function say_raw {
    local MESSAGE="$@"
    local PREFIX="🖥️  $"
    echo "$PREFIX $MESSAGE"
}

function comment_raw {
    local MESSAGE="$@"
    local PREFIX="$ENTER🖥️  #"
    echo "$PREFIX $MESSAGE"
}

function run_raw {
    local COMMAND="$@"
    if [ "🔇" == "$1" ] ; then
        shift 1
        local COMMAND="$@"
    else
        say_raw "$COMMAND"
    fi
    local LINE
    read LINE

    # Quit on "q"
    if [ "q" == "$LINE" ]; then
        exit
    fi

    $COMMAND
}

function say_rich {
    local MESSAGE="$@"
    local PREFIX="$PROMPT"
    rich --print "$PREFIX $MESSAGE"
}

function comment_rich {
    local MESSAGE="$@"
    local PREFIX="$ENTER$PROMPT [gray50]#"
    rich --print "$PREFIX $MESSAGE"
    unset MESSAGE
}

function run_rich {
    local COMMAND="$@"
    if [ "🔇" == "$1" ] ; then
        shift 1
        local COMMAND="$@"
    else
        say_rich "$COMMAND"
    fi
    local LINE
    read LINE

    # Quit on "q"
    if [ "q" == "$LINE" ]; then
        #bash
        exit
    fi

    $COMMAND
}

comment_raw "⚠️ This demo waits before every command, you will have to push enter to exec every time"

comment_raw "Installing pipxu"
run_raw pip install --upgrade pip uv pipxu


comment_raw "Installing rich_cli"
run_raw pipxu install rich_cli

USE_RICH=👍
comment_rich "Installing [green]gita"
run_rich pipxu install gita

comment_rich "[cyan]Get repos. Create dirs."
run_rich mkdir -p ~/repos/mios ~/repos/externos
say_rich "[orange3]gita [bright_green]clone [purple]-C ~/repos/externos [cyan]https://github.com/VigoTech/vigotech.github.io"
run_rich 🔇 gita clone -C ~/repos/externos https://github.com/VigoTech/vigotech.github.io
run_rich gita clone -C ~/repos/externos https://github.com/FHPythonUtils/AnsiToImg
run_rich gita clone -C ~/repos/mios https://github.com/Daniel-at-github/charla_xonsh
run_rich gita clone -C ~/repos/mios https://github.com/Daniel-at-github/p5_coding_train
comment_rich "[cyan]Four repos installed"
run_rich ls -ld ~/repos/*/*/.git

comment_rich "[cyan]Minimal git configuration to be able to commit"
run_rich git config --global user.email "you@example.com"
run_rich git config --global user.name "Your Name"

comment_rich "[green]List[/] all repos"
run_rich gita ll
comment_rich "[green]Forget[/] (gita) all repos"
run_rich gita clear
comment_rich "[green]Add[/] all repos, [green]grouping[/] by dir"
run_rich gita add -a ~/repos
comment_rich "[green]List[/] groups"
run_rich gita group
comment_rich "[green]List[/] repos by [green]groups"
run_rich gita ll -g

comment_rich "How are groups [green]internally[/] stored"
run_rich gita freeze

comment_rich "[cyan]Modify[/] a repo"
say_rich sed -i '"$ a Algo nuevo"' /opt/app-root/src/repos/mios/p5_coding_train/README.md
sed -i '$ a Algo nuevo' /opt/app-root/src/repos/mios/p5_coding_train/README.md
run_rich 🔇 :
comment_rich "[cyan]Add[/] a commit to a repo, with [green] super"
run_rich gita super p5_coding_train commit -am "New_stuff"
comment_rich "[cyan]Simulate[/] that we are 4 commits [cyan]behind[/], with [green] super"
run_rich gita super AnsiToImg reset HEAD~4

comment_rich "[green]List[/] our state"
run_rich gita ll -g
comment_rich "Show [green]help"
run_rich gita ll -h
say_rich "🎉 Fin 🏁"
