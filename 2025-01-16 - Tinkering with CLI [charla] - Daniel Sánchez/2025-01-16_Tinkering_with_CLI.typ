
// Packages
#import "@preview/touying:0.5.5": * // Slides
#import themes.metropolis: *

#import "@preview/ansi-render:0.8.0": *
/*
Example of how to capture a terminal output using the command line (the numbre of \ depends on the shell used):

ls -l /bin --color=always \
  | python -c "import sys, re; print(re.sub(r'\\\\x([0-9a-fA-F]{2})', lambda m: f'\\\\u{{{m.group(1)}}}', repr(sys.stdin.read().strip())[1:-1]))"

ls -l /bin --color=always | sed -e 's/\x1b/\\u{1b}/g' -e 's/"/\\"/g'

Then you can use the output like this:

#ansi-render("
lrwxrwxrwx. 11 root root 1 jan  1  1970 \u{1b}[0m\u{1b}[01;36m/bin\u{1b}[0m -> \u{1b}[01;34musr/bin\u{1b}[0m
"
*/

#let terminal(content) = {
  box(
    stroke: green,
    fill: black,
    inset: 10pt,
    radius: 5pt,
    width: 100%,
    [
      #set text(fill: green)
      #content
    ],
  )
}

#let render(content, size: 16pt) = {
  set text(font: "FiraCode Nerd Font", fill: green)
  ansi-render(
    content,
    inset: 5pt,
    radius: 3pt,
    theme: terminal-themes.vscode,
    size: size,
  )
}

// Tema
#show: metropolis-theme.with(aspect-ratio: "16-9")
// Diapositiva inicial
#show: metropolis-theme.with(
  aspect-ratio: "16-9",
  footer: self => self.info.institution,
  config-info(
    title: [Tinkering with CLI],
    subtitle: [Refining your terminal toolbox with pipx],
    author: [#text(font: "Noto Color Emoji")[🧔🏻]Daniel Sánchez],
    date: "🗓️ 2025-01-16",
    institution: [💻 Python Vigo],
    logo: [#text(font: "Noto Color Emoji")[🐍]],
  ),
)
#title-slide()

// Presentación
== CLI

#slide(composer: (1fr, 1fr))[
  CLI
  - Command Line Interface
  - For this talk, terminal Python programs
][
  #set text(font: "Noto Color Emoji", size: 200pt)
  // #set text(font: "Twitter Color Emoji",size: 200pt)
  #set align(center)
  🖥️
]


== Pipx

#link("https://github.com/pypa/pipx")[Pipx]

- Install Python applications CLI.
- Each in it's own isolated virtual environment.
- All of them accessible in the path.

== Pipx (Install)

Using your package manager
#terminal([
  ```sh
  sudo dnf install pipx
  ```
])
or with pip
#terminal([
  ```sh
  python -m ensurepip --upgrade # Up to date pip
  python -m pip install --upgrade pipx # Up to date pipx
  ```
])
Ensure the installed commands are in the path
#terminal([
  ```sh
  pipx ensurepath
  sudo pipx ensurepath --global # Same for all the users
  ```
])

== Pipx (Usage)

#terminal([

  ```sh
  pipx list
  ```
  // Not yaml. Just a HACK to show it different
  ```yaml
  nothing has been installed with pipx 😴
  ```
  ```sh
  pipx install cowsay
  ```
  ```yaml
    installed package cowsay 6.1, installed using Python 3.12.7
    These apps are now globally available
      - cowsay
  done! ✨ 🌟 ✨
  ```
  ```sh
  pipx list
  ```
  ```yaml
  venvs are in ~/.local/pipx/venvs
  apps are exposed on your $PATH at ~/.local/bin
  manual pages are exposed at ~/.local/share/man
     package cowsay 6.1, installed using Python 3.13.1
      - cowsay
  ```
])

== Pipx (Package usage) - Cowsay

#terminal([

  ```sh
  cowsay "Hola Python Vigo!"
  ```
  #render("
  _________________
| Hola Python Vigo! |
  =================
                 \
                  \
                    ^__^
                    (oo)\_______
                    (__)\       )\/\
                        ||----w |
                        ||     ||

")
])

== Pipx (Temporary Virtual Environment)

#terminal([

  ```sh
  pipx uninstall cowsay
  pipx run cowsay -c tux -t "Hello again"

  ```
  #render("  ___________
| Hello again |
  ===========
                \
                 \
                  \
                   .--.
                  |o_o |
                  |:_/ |
                 //   \ \
                (|     | )
               /'\_   _/`\
               \___)=(___/
")
  // `
])

== Pipx (Administration)
Manually upgrading packages
#terminal([
  ```sh
  pipx upgrade-all
  ```
])
Reinstalling packages (needed python version upgrades. Ex: 3.12 → 3.13)
#terminal([
  ```sh
  pipx reinstall-all
  ```
])
Reinstalling packages (needed python version upgrades. Ex: 3.12 → 3.13)
#terminal([
  ```sh
  pipx install ansible ansitoimg black bpytop chime commitizen copier datasette dunk edge-tts fnug gita glances hent isort jc jupyterlab lektor lightnovel-crawler llm lolcat markdown-anki-decks mdformat mypy percol pipenv pls pre-commit pyfiglet pytest pyupgrade rich-cli ruff s-tui streamlit terminaltexteffects tiptop tmuxp toolong topgrade uv visidata wsgidav xonsh yq yt-dlp
  ```
])




== Pipx with pre-commit

This lets you run applications that can be run using pipx run but don't have native pre-commit support.

Example configuration for use of the code linter yapf. This is to be added to your .pre-commit-config.yaml.
```yaml
- repo: https://github.com/pypa/pipx
  rev: 1.5.0
  hooks:
    - id: pipx
      alias: yapf
      name: yapf
      args: ["yapf", "-i"]
      types: ["python"]
```

== Pipxu

Install and Run Python Applications in Isolated Environments using UV

- Pipx faster replacement in rust
- Last time I tried failed with some packages
- Retrying now
  - Not sure how update-all
  - Fails with glances
  - Says that install all, but installs 11/46
- Will retry in the future

== Packages

#columns(
  5,
  [

    === Oddities
    - pyfiglet
    - lolcat
    - cowsay
    - terminal text effects

    === Productivity
    - rich-cli
    - tmuxp
    - xonsh
    - pls
    - percol
    - chime
    - jc
    - wsgidav

    === Sysadmin
    - hent
    - glances
    - tiptop
    - bpytop
    - s-tui
    - ansible
    - toolong
    - topgrade

    === Dev
    - commitizen
    - dunk
    - gita
    - pre-commit
    - mdformat
    - copier

    === Python dev
    - black
    - isort
    - mypy
    - ruff
    - uv
    - pytest
    - pyupgrade

    === Data science
    - datasette
    - jupyterlab
    - streamlit
    - visidata

    === IA
    - llm

    === Media
    - yt-dlp
    - lightnovel-crawler

    === Other
    - ansitoimg
    - lektor
    - markdown-anki-decks
    - pyxel
  ],
)

== pyfiglet

Pure-python FIGlet implementation

It takes ASCII text and renders it in ASCII art fonts

#terminal([
  ```sh
  pipx install pyfiglet
  pyfiglet "--font=banner3-D" "--width=200" All good
  ```
  #render(
    "
:::'###::::'##:::::::'##:::::::::::'######::::'#######:::'#######::'########::
::'## ##::: ##::::::: ##::::::::::'##... ##::'##.... ##:'##.... ##: ##.... ##:
:'##:. ##:: ##::::::: ##:::::::::: ##:::..::: ##:::: ##: ##:::: ##: ##:::: ##:
'##:::. ##: ##::::::: ##:::::::::: ##::'####: ##:::: ##: ##:::: ##: ##:::: ##:
 #########: ##::::::: ##:::::::::: ##::: ##:: ##:::: ##: ##:::: ##: ##:::: ##:
 ##.... ##: ##::::::: ##:::::::::: ##::: ##:: ##:::: ##: ##:::: ##: ##:::: ##:
 ##:::: ##: ########: ########::::. ######:::. #######::. #######:: ########::
..:::::..::........::........::::::......:::::.......::::.......:::........:::
",
    size: 15pt,
  )
])

== lolcat

Rainbows and unicorns!

#terminal([
  ```sh
  pyfiglet "--font=dos_rebel" "--width=89" lolcat \
  | lolcat
  ```
  // #render(read("out/lolcat.out"))
  #render("\u{1b}[38;5;49m \u{1b}[38;5;48m█\u{1b}[38;5;48m█\u{1b}[38;5;48m█\u{1b}[38;5;48m█\u{1b}[38;5;48m \u{1b}[38;5;48m \u{1b}[38;5;48m \u{1b}[38;5;48m \u{1b}[38;5;48m \u{1b}[38;5;84m \u{1b}[38;5;83m \u{1b}[38;5;83m \u{1b}[38;5;83m \u{1b}[38;5;83m \u{1b}[38;5;83m \u{1b}[38;5;83m█\u{1b}[38;5;83m█\u{1b}[38;5;83m█\u{1b}[38;5;83m█\u{1b}[38;5;83m \u{1b}[38;5;83m \u{1b}[38;5;119m \u{1b}[38;5;118m \u{1b}[38;5;118m \u{1b}[38;5;118m \u{1b}[38;5;118m \u{1b}[38;5;118m \u{1b}[38;5;118m \u{1b}[38;5;118m \u{1b}[38;5;118m \u{1b}[38;5;118m \u{1b}[38;5;154m \u{1b}[38;5;154m \u{1b}[38;5;154m \u{1b}[38;5;154m \u{1b}[38;5;154m \u{1b}[38;5;154m \u{1b}[38;5;154m \u{1b}[38;5;154m \u{1b}[38;5;154m \u{1b}[38;5;148m \u{1b}[38;5;184m█\u{1b}[38;5;184m█\u{1b}[38;5;184m█\u{1b}[38;5;184m█\u{1b}[38;5;184m█\n\u{1b}[38;5;48m░\u{1b}[38;5;48m░\u{1b}[38;5;48m█\u{1b}[38;5;48m█\u{1b}[38;5;48m█\u{1b}[38;5;48m \u{1b}[38;5;48m \u{1b}[38;5;84m \u{1b}[38;5;83m \u{1b}[38;5;83m \u{1b}[38;5;83m \u{1b}[38;5;83m \u{1b}[38;5;83m \u{1b}[38;5;83m \u{1b}[38;5;83m \u{1b}[38;5;83m░\u{1b}[38;5;83m░\u{1b}[38;5;83m█\u{1b}[38;5;83m█\u{1b}[38;5;119m█\u{1b}[38;5;118m \u{1b}[38;5;118m \u{1b}[38;5;118m \u{1b}[38;5;118m \u{1b}[38;5;118m \u{1b}[38;5;118m \u{1b}[38;5;118m \u{1b}[38;5;118m \u{1b}[38;5;118m \u{1b}[38;5;154m \u{1b}[38;5;154m \u{1b}[38;5;154m \u{1b}[38;5;154m \u{1b}[38;5;154m \u{1b}[38;5;154m \u{1b}[38;5;154m \u{1b}[38;5;154m \u{1b}[38;5;154m \u{1b}[38;5;148m \u{1b}[38;5;184m \u{1b}[38;5;184m \u{1b}[38;5;184m░\u{1b}[38;5;184m░\u{1b}[38;5;184m█\u{1b}[38;5;184m█\u{1b}[38;5;184m█\n\u{1b}[38;5;48m \u{1b}[38;5;48m░\u{1b}[38;5;48m█\u{1b}[38;5;48m█\u{1b}[38;5;84m█\u{1b}[38;5;83m \u{1b}[38;5;83m \u{1b}[38;5;83m \u{1b}[38;5;83m█\u{1b}[38;5;83m█\u{1b}[38;5;83m█\u{1b}[38;5;83m█\u{1b}[38;5;83m█\u{1b}[38;5;83m█\u{1b}[38;5;83m \u{1b}[38;5;83m \u{1b}[38;5;119m░\u{1b}[38;5;118m█\u{1b}[38;5;118m█\u{1b}[38;5;118m█\u{1b}[38;5;118m \u{1b}[38;5;118m \u{1b}[38;5;118m \u{1b}[38;5;118m█\u{1b}[38;5;118m█\u{1b}[38;5;118m█\u{1b}[38;5;154m█\u{1b}[38;5;154m█\u{1b}[38;5;154m█\u{1b}[38;5;154m \u{1b}[38;5;154m \u{1b}[38;5;154m \u{1b}[38;5;154m█\u{1b}[38;5;154m█\u{1b}[38;5;154m█\u{1b}[38;5;148m█\u{1b}[38;5;184m█\u{1b}[38;5;184m█\u{1b}[38;5;184m \u{1b}[38;5;184m \u{1b}[38;5;184m \u{1b}[38;5;184m█\u{1b}[38;5;184m█\u{1b}[38;5;184m█\u{1b}[38;5;184m█\u{1b}[38;5;184m█\u{1b}[38;5;184m█\u{1b}[38;5;178m█\n\u{1b}[38;5;48m \u{1b}[38;5;84m░\u{1b}[38;5;83m█\u{1b}[38;5;83m█\u{1b}[38;5;83m█\u{1b}[38;5;83m \u{1b}[38;5;83m \u{1b}[38;5;83m█\u{1b}[38;5;83m█\u{1b}[38;5;83m█\u{1b}[38;5;83m░\u{1b}[38;5;83m░\u{1b}[38;5;83m█\u{1b}[38;5;119m█\u{1b}[38;5;118m█\u{1b}[38;5;118m \u{1b}[38;5;118m░\u{1b}[38;5;118m█\u{1b}[38;5;118m█\u{1b}[38;5;118m█\u{1b}[38;5;118m \u{1b}[38;5;118m \u{1b}[38;5;118m█\u{1b}[38;5;154m█\u{1b}[38;5;154m█\u{1b}[38;5;154m░\u{1b}[38;5;154m░\u{1b}[38;5;154m█\u{1b}[38;5;154m█\u{1b}[38;5;154m█\u{1b}[38;5;154m \u{1b}[38;5;154m░\u{1b}[38;5;148m░\u{1b}[38;5;184m░\u{1b}[38;5;184m░\u{1b}[38;5;184m░\u{1b}[38;5;184m█\u{1b}[38;5;184m█\u{1b}[38;5;184m█\u{1b}[38;5;184m \u{1b}[38;5;184m░\u{1b}[38;5;184m░\u{1b}[38;5;184m░\u{1b}[38;5;184m█\u{1b}[38;5;178m█\u{1b}[38;5;214m█\u{1b}[38;5;214m░\n\u{1b}[38;5;83m \u{1b}[38;5;83m░\u{1b}[38;5;83m█\u{1b}[38;5;83m█\u{1b}[38;5;83m█\u{1b}[38;5;83m \u{1b}[38;5;83m░\u{1b}[38;5;83m█\u{1b}[38;5;83m█\u{1b}[38;5;83m█\u{1b}[38;5;119m \u{1b}[38;5;118m░\u{1b}[38;5;118m█\u{1b}[38;5;118m█\u{1b}[38;5;118m█\u{1b}[38;5;118m \u{1b}[38;5;118m░\u{1b}[38;5;118m█\u{1b}[38;5;118m█\u{1b}[38;5;118m█\u{1b}[38;5;154m \u{1b}[38;5;154m░\u{1b}[38;5;154m█\u{1b}[38;5;154m█\u{1b}[38;5;154m█\u{1b}[38;5;154m \u{1b}[38;5;154m░\u{1b}[38;5;154m░\u{1b}[38;5;154m░\u{1b}[38;5;148m \u{1b}[38;5;184m \u{1b}[38;5;184m \u{1b}[38;5;184m█\u{1b}[38;5;184m█\u{1b}[38;5;184m█\u{1b}[38;5;184m█\u{1b}[38;5;184m█\u{1b}[38;5;184m█\u{1b}[38;5;184m█\u{1b}[38;5;184m \u{1b}[38;5;184m \u{1b}[38;5;178m \u{1b}[38;5;214m░\u{1b}[38;5;214m█\u{1b}[38;5;214m█\u{1b}[38;5;214m█\n\u{1b}[38;5;83m \u{1b}[38;5;83m░\u{1b}[38;5;83m█\u{1b}[38;5;83m█\u{1b}[38;5;83m█\u{1b}[38;5;83m \u{1b}[38;5;83m░\u{1b}[38;5;119m█\u{1b}[38;5;118m█\u{1b}[38;5;118m█\u{1b}[38;5;118m \u{1b}[38;5;118m░\u{1b}[38;5;118m█\u{1b}[38;5;118m█\u{1b}[38;5;118m█\u{1b}[38;5;118m \u{1b}[38;5;118m░\u{1b}[38;5;154m█\u{1b}[38;5;154m█\u{1b}[38;5;154m█\u{1b}[38;5;154m \u{1b}[38;5;154m░\u{1b}[38;5;154m█\u{1b}[38;5;154m█\u{1b}[38;5;154m█\u{1b}[38;5;154m \u{1b}[38;5;148m \u{1b}[38;5;184m█\u{1b}[38;5;184m█\u{1b}[38;5;184m█\u{1b}[38;5;184m \u{1b}[38;5;184m█\u{1b}[38;5;184m█\u{1b}[38;5;184m█\u{1b}[38;5;184m░\u{1b}[38;5;184m░\u{1b}[38;5;184m█\u{1b}[38;5;184m█\u{1b}[38;5;178m█\u{1b}[38;5;214m \u{1b}[38;5;214m \u{1b}[38;5;214m \u{1b}[38;5;214m░\u{1b}[38;5;214m█\u{1b}[38;5;214m█\u{1b}[38;5;214m█\u{1b}[38;5;214m \u{1b}[38;5;214m█\u{1b}[38;5;208m█\u{1b}[38;5;208m█\n\u{1b}[38;5;83m \u{1b}[38;5;83m█\u{1b}[38;5;83m█\u{1b}[38;5;83m█\u{1b}[38;5;119m█\u{1b}[38;5;118m█\u{1b}[38;5;118m░\u{1b}[38;5;118m░\u{1b}[38;5;118m█\u{1b}[38;5;118m█\u{1b}[38;5;118m█\u{1b}[38;5;118m█\u{1b}[38;5;118m█\u{1b}[38;5;118m█\u{1b}[38;5;154m \u{1b}[38;5;154m \u{1b}[38;5;154m█\u{1b}[38;5;154m█\u{1b}[38;5;154m█\u{1b}[38;5;154m█\u{1b}[38;5;154m█\u{1b}[38;5;154m░\u{1b}[38;5;154m░\u{1b}[38;5;148m█\u{1b}[38;5;184m█\u{1b}[38;5;184m█\u{1b}[38;5;184m█\u{1b}[38;5;184m█\u{1b}[38;5;184m█\u{1b}[38;5;184m \u{1b}[38;5;184m░\u{1b}[38;5;184m░\u{1b}[38;5;184m█\u{1b}[38;5;184m█\u{1b}[38;5;184m█\u{1b}[38;5;178m█\u{1b}[38;5;214m█\u{1b}[38;5;214m█\u{1b}[38;5;214m█\u{1b}[38;5;214m█\u{1b}[38;5;214m \u{1b}[38;5;214m \u{1b}[38;5;214m░\u{1b}[38;5;214m░\u{1b}[38;5;214m█\u{1b}[38;5;208m█\u{1b}[38;5;208m█\u{1b}[38;5;208m█\u{1b}[38;5;208m█\n\u{1b}[38;5;83m░\u{1b}[38;5;119m░\u{1b}[38;5;118m░\u{1b}[38;5;118m░\u{1b}[38;5;118m░\u{1b}[38;5;118m \u{1b}[38;5;118m \u{1b}[38;5;118m░\u{1b}[38;5;118m░\u{1b}[38;5;118m░\u{1b}[38;5;118m░\u{1b}[38;5;154m░\u{1b}[38;5;154m░\u{1b}[38;5;154m \u{1b}[38;5;154m \u{1b}[38;5;154m░\u{1b}[38;5;154m░\u{1b}[38;5;154m░\u{1b}[38;5;154m░\u{1b}[38;5;154m░\u{1b}[38;5;148m \u{1b}[38;5;184m \u{1b}[38;5;184m░\u{1b}[38;5;184m░\u{1b}[38;5;184m░\u{1b}[38;5;184m░\u{1b}[38;5;184m░\u{1b}[38;5;184m░\u{1b}[38;5;184m \u{1b}[38;5;184m \u{1b}[38;5;184m \u{1b}[38;5;184m░\u{1b}[38;5;178m░\u{1b}[38;5;214m░\u{1b}[38;5;214m░\u{1b}[38;5;214m░\u{1b}[38;5;214m░\u{1b}[38;5;214m░\u{1b}[38;5;214m░\u{1b}[38;5;214m \u{1b}[38;5;214m \u{1b}[38;5;214m \u{1b}[38;5;208m \u{1b}[38;5;208m░\u{1b}[38;5;208m░\u{1b}[38;5;208m░\u{1b}[38;5;208m░\u{1b}[38;5;208m░\n\n\n\n\n\u{1b}[0m")
])

== terminaltexteffects

TerminalTextEffects (TTE) is a terminal visual effects engine

#terminal([
  ```sh
  ls -l /etc | head \
  | tte decrypt --typing-speed 10 \
      --ciphertext-colors 008000 00cb00 00ff00 \
      --final-gradient-stops eda000 \
      --final-gradient-steps 12 \
      --final-gradient-direction vertical
  # See demo
  ```
])

== rich-cli (files)
Rich-cli is a command line toolbox for fancy output in the terminal
#table(columns: (1fr, 1fr), stroke: none,)[
  #terminal([
    ```sh
    rich tmp.py --guides --line-numbers
    ```
    #render("  \u{1b}[2m1 \u{1b}[0m\u{1b}[94mdef\u{1b}[0m\u{1b}[90m \u{1b}[0m\u{1b}[92mgreetings\u{1b}[0m():
  \u{1b}[2m2 \u{1b}[0m\u{1b}[2m│   \u{1b}[0m\u{1b}[96mprint\u{1b}[0m(\u{1b}[33m'\u{1b}[0m\u{1b}[33mHello Vigo!\u{1b}[0m\u{1b}[33m'\u{1b}[0m)
  \u{1b}[2m3\n\n\n\n")
  ])
][
  #terminal([
    ```sh
    rich tmp.md
    ```
    #render("╔═════════════════════════════════════════╗
║              \u{1b}[1mPython Vigo\u{1b}[0m                ║
╚═════════════════════════════════════════╝
\u{1b}[1;33m • \u{1b}[0m🎤 Talk
\u{1b}[1;33m • \u{1b}[0m⚡ Lightnings
\u{1b}[1;33m • \u{1b}[0m🍺 Vegan beers
")
  ])
][
  #terminal([
    ```sh
    rich tmp.json --line-numbers
    ```
    #render("\u{1b}[1m{\u{1b}[0m
  \u{1b}[1;34m\"pythonVigo\"\u{1b}[0m: \u{1b}[1m{\u{1b}[0m
    \u{1b}[1;34m\"name\"\u{1b}[0m: \u{1b}[32m\"Python Vigo Meetup\"\u{1b}[0m,
    \u{1b}[1;34m\"date\"\u{1b}[0m: \u{1b}[32m\"2025-01-16\"\u{1b}[0m
  \u{1b}[1m}\u{1b}[0m
\u{1b}[1m}\u{1b}[0m
\u{1b}[?2004h\u{1b}[?2004l")
  ])
][ ... and csv, ipnb, rst (restructured text) ]

== rich-cli (messages)

#terminal([
  ```sh
  rich --emoji --style "on dark_blue" --print --panel rounded  \
     "Writing [red]colored[/] markup :tada:"
  ```
  #render("\u{1b}[48;5;18m╭───────────────────────────╮\u{1b}[0m
\u{1b}[48;5;18m│\u{1b}[0m\u{1b}[48;5;18m \u{1b}[0m\u{1b}[48;5;18mWriting \u{1b}[0m\u{1b}[31;48;5;18mcolored\u{1b}[0m\u{1b}[48;5;18m markup 🎉\u{1b}[0m\u{1b}[48;5;18m \u{1b}[0m\u{1b}[48;5;18m│\u{1b}[0m
\u{1b}[48;5;18m╰───────────────────────────╯\u{1b}[0m")
])
#terminal([
  ```sh
  rich "Status [b]OK[/b]" --rule --rule-style "green"
  ```
  #render("\u{1b}[32m────────────────────────────────────────── \u{1b}[0mStatus \u{1b}[1mOK\u{1b}[0m\u{1b}[32m ───────────────────────────────────────────\u{1b}[0m")
])
#terminal([
  ```sh
  rich "Hello [b]World[/b]!" -p -c --padding 2 --style "on blue"
  ```
  #render("          \u{1b}[44m                \u{1b}[0m
          \u{1b}[44m                \u{1b}[0m
          \u{1b}[44m  \u{1b}[0m\u{1b}[44mHello \u{1b}[0m\u{1b}[1;44mWorld\u{1b}[0m\u{1b}[44m!\u{1b}[0m\u{1b}[44m  \u{1b}[0m
          \u{1b}[44m                \u{1b}[0m
          \u{1b}[44m                \u{1b}[0m
\u{1b}[?2004h\u{1b}[?2004l")
])


== hent
A neofetch alternative written in python.
#terminal([
  ```sh
  hent
  ```
  #render("
\u{1b}[34m       ......        \u{1b}[0m \u{1b}[34m  Distro:\u{1b}[0m Fedora Linux 41.20250116.0 (Kinoite)
\u{1b}[34m    .....'cdxx;.     \u{1b}[0m \u{1b}[34m  Kernel:\u{1b}[0m 6.12.9-200.fc41.x86_64
\u{1b}[34m  ......:NNxll::,.   \u{1b}[0m \u{1b}[34m  Uptime:\u{1b}[0m 3 hours, 58 minutes
\u{1b}[34m .......kMo...':;..  \u{1b}[0m \u{1b}[34mPackages:\u{1b}[0m 1881 (rpm), 103 (flatpak)
\u{1b}[34m ..',cO0NMX0O::;'..  \u{1b}[0m \u{1b}[34m   Shell:\u{1b}[0m bash
\u{1b}[34m .;:,';:OMx:;''....  \u{1b}[0m \u{1b}[34mTerminal:\u{1b}[0m unknown
\u{1b}[34m .::'..'KMc.......   \u{1b}[0m \u{1b}[34m     CPU:\u{1b}[0m AMD Ryzen 3 3200G with Radeon Vega Graphics
\u{1b}[34m .';dXXWKl......     \u{1b}[0m \u{1b}[34m     GPU:\u{1b}[0m Radeon Vega Series / Radeon Vega Mobile Series
\u{1b}[34m  ...',......        \u{1b}[0m \u{1b}[34m  Memory:\u{1b}[0m 3733MB / 6002MB
")
])

== tmuxp (🎉 Demo)

Session manager for tmux, that save and load tmux sessions in simple configuration files.

#terminal([
  ```sh
  tmux # tmuxp freeze inside
  tmuxp list
  tmuxp load terminaltexteffects # See below ~/.tmuxp/terminaltexteffects.yaml
  ```
])
#terminal([
  #text(size: 12pt)[
    ```yml
    # ~/.tmuxp/terminaltexteffects.yaml
    session_name: 'terminaltexteffects'
    start_directory: '~'
    global_options:
      default-shell: ~/.local/bin/xonsh
    windows:
      - window_name: tte
        focus: 'true'
        layout: tiled
        options:
          mouse: yes
        panes:
          - hent | tte --no-color print
          - hent | tte burn
          - hent | tte decrypt
          - hent | tte rain
        start_directory: ~/
    ```
  ]
])

== xonsh

Python-powered shell. Full-featured and cross-platform.

#terminal([
  ```sh
  xxx
  ```
  #render("")
])

== pls

*pls* is a prettier and powerful `ls` for the pros.
- Cleaner and more readable colorful output
- Uses `Nerd Fonts`
- Fast and small (rust)
- Good filtering
- Unique display style for symlinks and symlink chains
#terminal([
  ```sh
  pls /tmp/
  ```
  #render("\u{1b}[0m   \u{1b}[38;2;227;79;38mtmp.html\u{1b}[0m
   tmp.json
   tmp.md
\u{1b}[38;2;55;118;171m\u{1b}[0m   \u{1b}[38;2;55;118;171mtmp.py\u{1b}[0m")
])

== percol

Adds flavor of interactive filtering to the traditional pipe concept of UNIX shell

#terminal([
  ```sh
  cd $(find -type d | percol)
  ls /bin | percol --prompt="Choose file "
  ```
])

== chime

Python sound notifications made easy.

#terminal([
  ```sh
  chime --theme mario info
  # Mario bros "geting coin" sound

  chime --help
  usage: chime [-h] [--theme THEME] [event]

  positional arguments:
    event          either one of {success, warning, error, info}

  options:
    -h, --help     show this help message and exit
    --theme THEME  either one of {big-sur, chime, mario, material, pokemon, sonic, zelda}

  ```
])

== edge-tts ⛈️

Use Microsoft Edge's online text-to-speech service from Python WITHOUT needing Microsoft Edge or Windows or an API key

#terminal([
  ```sh
  edge-tts --list-voices | grep es-ES
  ```
  ```
  es-ES-AlvaroNeural  Male      General Friendly, Positive
  es-ES-ElviraNeural  Female    General Friendly, Positive
  es-ES-XimenaNeural  Female    General Friendly, Positive
  ```
  ```sh
  edge-playback --voice 'es-ES-XimenaNeural' \
    --text 'Este es el contestador avanzado de Python'
  ```

])

== jc

Converts the output of popular command-line tools and file-types to JSON.

#terminal([
  ```sh
  date -Is | jc --datetime-iso
  ```
  #render("{\u{1b}[34;01m\"year\"\u{1b}[39;00m:\u{1b}[35m2025\u{1b}[39m,\u{1b}[34;01m\"month\"\u{1b}[39;00m:\u{1b}[32m\"Jan\"\u{1b}[39m,\u{1b}[34;01m\"month_num\"\u{1b}[39;00m:\u{1b}[35m1\u{1b}[39m,\u{1b}[34;01m\"day\"\u{1b}[39;00m:\u{1b}[35m15\u{1b}[39m,\u{1b}[34;01m\"weekday\"\u{1b}[39;00m:\u{1b}[32m\"Wed\"\u{1b}[39m,\u{1b}[34;01m\"weekday_num\"\u{1b}[39;00m:\u{1b}[35m3\u{1b}[39m,\u{1b}[34;01m\"hour\"\u{1b}[39;00m:\u{1b}[35m10\u{1b}[39m,\u{1b}[34;01m\"hour_24\"\u{1b}[39;00m:\u{1b}[35m22\u{1b}[39m,\u{1b}[34;01m\"minute\"\u{1b}[39;00m:\u{1b}[35m28\u{1b}[39m,\u{1b}[34;01m\"second\"\u{1b}[39;00m:\u{1b}[35m36\u{1b}[39m,\u{1b}[34;01m\"microsecond\"\u{1b}[39;00m:\u{1b}[35m0\u{1b}[39m,\u{1b}[34;01m\"period\"\u{1b}[39;00m:\u{1b}[32m\"PM\"\u{1b}[39m,\u{1b}[34;01m\"utc_offset\"\u{1b}[39;00m:\u{1b}[32m\"+0100\"\u{1b}[39m,\u{1b}[34;01m\"day_of_year\"\u{1b}[39;00m:\u{1b}[35m15\u{1b}[39m,\u{1b}[34;01m\"week_of_year\"\u{1b}[39;00m:\u{1b}[35m2\u{1b}[39m,\u{1b}[34;01m\"iso\"\u{1b}[39;00m:\u{1b}[32m\"2025-01-15T22:28:36+01:00\"\u{1b}[39m,\u{1b}[34;01m\"timestamp\"\u{1b}[39;00m:\u{1b}[35m1736976516\u{1b}[39m}")
  ```sh
  dig example.com | jc --dig
  ```
  #render("[{\u{1b}[34;01m\"id\"\u{1b}[39;00m:\u{1b}[35m39078\u{1b}[39m,\u{1b}[34;01m\"opcode\"\u{1b}[39;00m:\u{1b}[32m\"QUERY\"\u{1b}[39m,\u{1b}[34;01m\"status\"\u{1b}[39;00m:\u{1b}[32m\"NOERROR\"\u{1b}[39m,\u{1b}[34;01m\"flags\"\u{1b}[39;00m:[\u{1b}[32m\"qr\"\u{1b}[39m,\u{1b}[32m\"rd\"\u{1b}[39m,\u{1b}[32m\"ra\"\u{1b}[39m],\u{1b}[34;01m\"query_num\"\u{1b}[39;00m:\u{1b}[35m1\u{1b}[39m,\u{1b}[34;01m\"answer_num\"\u{1b}[39;00m:\u{1b}[35m6\u{1b}[39m,\u{1b}[34;01m\"authority_num\"\u{1b}[39;00m:\u{1b}[35m0\u{1b}[39m,\u{1b}[34;01m\"additional_num\"\u{1b}[39;00m:\u{1b}[35m1\u{1b}[39m,\u{1b}[34;01m\"opt_pseudosection\"\u{1b}[39;00m:{\u{1b}[34;01m\"edns\"\u{1b}[39;00m:{\u{1b}[34;01m\"version\"\u{1b}[39;00m:\u{1b}[35m0\u{1b}[39m,\u{1b}[34;01m\"flags\"\u{1b}[39;00m:[],\u{1b}[34;01m\"udp\"\u{1b}[39;00m:\u{1b}[35m512\u{1b}[39m}},\u{1b}[34;01m\"question\"\u{1b}[39;00m:{\u{1b}[34;01m\"name\"\u{1b}[39;00m:\u{1b}[32m\"example.com.\"\u{1b}[39m,\u{1b}[34;01m\"class\"\u{1b}[39;00m:\u{1b}[32m\"IN\"\u{1b}[39m,\u{1b}[34;01m\"type\"\u{1b}[39;00m:\u{1b}[32m\"A\"\u{1b}[39m},\u{1b}[34;01m\"answer\"\u{1b}[39;00m:[{\u{1b}[34;01m\"name\"\u{1b}[39;00m:\u{1b}[32m\"example.com.\"\u{1b}[39m,\u{1b}[34;01m\"class\"\u{1b}[39;00m:\u{1b}[32m\"IN\"\u{1b}[39m,\u{1b}[34;01m\"type\"\u{1b}[39;00m:\u{1b}[32m\"A\"\u{1b}[39m,\u{1b}[34;01m\"ttl\"\u{1b}[39;00m:\u{1b}[35m186\u{1b}[39m,\u{1b}[34;01m\"data\"\u{1b}[39;00m:\u{1b}[32m\"96.7.128.175\"\u{1b}[39m},{\u{1b}[34;01m\"name\"\u{1b}[39;00m:\u{1b}[32m\"example.com.\"\u{1b}[39m,\u{1b}[34;01m\"class\"\u{1b}[39;00m:\u{1b}[32m\"IN\"\u{1b}[39m,\u{1b}[34;01m\"type\"\u{1b}[39;00m:\u{1b}[32m\"A\"\u{1b}[39m,\u{1b}[34;01m\"ttl\"\u{1b}[39;00m:\u{1b}[35m186\u{1b}[39m,\u{1b}[34;01m\"data\"\u{1b}[39;00m:\u{1b}[32m\"96.7.128.198\"\u{1b}[39m},{\u{1b}[34;01m\"name\"\u{1b}[39;00m:\u{1b}[32m\"example.com.\"\u{1b}[39m,\u{1b}[34;01m\"class\"\u{1b}[39;00m:\u{1b}[32m\"IN\"\u{1b}[39m,\u{1b}[34;01m\"type\"\u{1b}[39;00m:\u{1b}[32m\"A\"\u{1b}[39m,\u{1b}[34;01m\"ttl\"\u{1b}[39;00m:\u{1b}[35m186\u{1b}[39m,\u{1b}[34;01m\"data\"\u{1b}[39;00m:\u{1b}[32m\"23.192.228.80\"\u{1b}[39m},{\u{1b}[34;01m\"name\"\u{1b}[39;00m:\u{1b}[32m\"example.com.\"\u{1b}[39m,\u{1b}[34;01m\"class\"\u{1b}[39;00m:\u{1b}[32m\"IN\"\u{1b}[39m,\u{1b}[34;01m\"type\"\u{1b}[39;00m:\u{1b}[32m\"A\"\u{1b}[39m,\u{1b}[34;01m\"ttl\"\u{1b}[39;00m:\u{1b}[35m186\u{1b}[39m,\u{1b}[34;01m\"data\"\u{1b}[39;00m:\u{1b}[32m\"23.192.228.84\"\u{1b}[39m},{\u{1b}[34;01m\"name\"\u{1b}[39;00m:\u{1b}[32m\"example.com.\"\u{1b}[39m,\u{1b}[34;01m\"class\"\u{1b}[39;00m:\u{1b}[32m\"IN\"\u{1b}[39m,\u{1b}[34;01m\"type\"\u{1b}[39;00m:\u{1b}[32m\"A\"\u{1b}[39m,\u{1b}[34;01m\"ttl\"\u{1b}[39;00m:\u{1b}[35m186\u{1b}[39m,\u{1b}[34;01m\"data\"\u{1b}[39;00m:\u{1b}[32m\"23.215.0.136\"\u{1b}[39m},{\u{1b}[34;01m\"name\"\u{1b}[39;00m:\u{1b}[32m\"example.com.\"\u{1b}[39m,\u{1b}[34;01m\"class\"\u{1b}[39;00m:\u{1b}[32m\"IN\"\u{1b}[39m,\u{1b}[34;01m\"type\"\u{1b}[39;00m:\u{1b}[32m\"A\"\u{1b}[39m,\u{1b}[34;01m\"ttl\"\u{1b}[39;00m:\u{1b}[35m186\u{1b}[39m,\u{1b}[34;01m\"data\"\u{1b}[39;00m:\u{1b}[32m\"23.215.0.138\"\u{1b}[39m}],\u{1b}[34;01m\"query_time\"\u{1b}[39;00m:\u{1b}[35m10\u{1b}[39m,\u{1b}[34;01m\"server\"\u{1b}[39;00m:\u{1b}[32m\"77.26.11.232#53(77.26.11.232) (UDP)\"\u{1b}[39m,\u{1b}[34;01m\"when\"\u{1b}[39;00m:\u{1b}[32m\"Wed Jan 15 22:46:14 CET 2025\"\u{1b}[39m,\u{1b}[34;01m\"rcvd\"\u{1b}[39;00m:\u{1b}[35m136\u{1b}[39m,\u{1b}[34;01m\"when_epoch\"\u{1b}[39;00m:\u{1b}[35m1736977574\u{1b}[39m,\u{1b}[34;01m\"when_epoch_utc\"\u{1b}[39;00m:\u{1b}[90mnull\u{1b}[39m}]")
])


== wsgidav
Generic and extendable WebDAV server based on WSGI
#terminal([
  ```sh
  pipx inject wsgidav lxml cheroot python-pam # Add python dependencies
  # Easy sharing with a Windows machine
  ```
  ⚠️
  ```sh
  # Secure risk: No password
  wsgidav --host=0.0.0.0 --port=8080 --auth=anonymous --root=$FOLDER_TO_SHARE
  xdg-open webdav://192.168.0.27:8080/
  ```
])

== glances
#align(top)[A cross-platform curses-based monitoring tool]
#align(center)[
  #set text(size: 40pt)
  🤖 Demo
]

== tiptop
#align(top)[A better top]
#align(center)[
  #set text(size: 40pt)
  🎸 Demo
]

== bpytop
#align(top)[Resource monitor that shows usage and stats for processor, memory, disks, network and processes.]
#align(center)[
  #set text(size: 40pt)
  🌈 Demo
]
== s-tui
#align(top)[Stress Terminal UI stress test and monitoring tool

  Monitors CPU temperature, frequency, power and utilization in a graphical way from the terminal.]
#align(center)[
  #set text(size: 40pt)
  🔥 Demo
]
== ansible
Radically simple IT automation
- A talk on itself
- Agent-less configuration manager
- Modules to accomplish tasks. Programs (usually python that get json parameters, do the job, returns json of the result).
- Playbooks that have a list of tasks.
- $"Playbooks" subset.eq "Modules" subset.eq "Collections"$
- There are modules and collections of whatever you can think of, from system administration tasks to cloud management, networking, provisioning, security, user management, ...

== toolong
#align(top)[A terminal log file viewer / tailer / analyzer
  #terminal([
    ```sh
    tl test.jsonl
    ```
  ])]
#align(center)[
  #set text(size: 40pt)
  🪵 Demo
]
== topgrade
Upgrade all the things

#terminal([
  ```sh
  topgrade --dry-run
  # topgrade
  ```
])]

⚠️ Excessive automation is indistinguishable from magic 🪄 🧹🪣🧹🪣🧹🪣 🌊🌊🌊🌊

== commitizen
Python commitizen client tool
Being Commitizen is release management tool designed for teams.
By default, commitizen uses conventional commits,

== dunk
Prettier git diffs in the terminal
#terminal([
  ```sh
  git diff | dunk | less -R
  ```
  #render("                                    \u{1b}[1;34m1\u{1b}[0m\u{1b}[34m file changed\u{1b}[0m
                              \u{1b}[1;32m+160 \u{1b}[0m\u{1b}[32m━━━━━━━━━━━━━━━\u{1b}[0m\u{1b}[32m╸\u{1b}[0m\u{1b}[31m━\u{1b}[0m \u{1b}[1;31m-14\u{1b}[0m

\u{1b}[38;2;62;64;54m▁ \u{1b}[0m\u{1b}[1mcharlas/\u{1b}[0m\u{1b}[1;36m2025\u{1b}[0m\u{1b}[1m-\u{1b}[0m\u{1b}[1;36m01\u{1b}[0m\u{1b}[1m-16_Tinkering_with_CLI/\u{1b}[0m\u{1b}[1;36m2025\u{1b}[0m\u{1b}[1m-\u{1b}[0m\u{1b}[1;36m01\u{1b}[0m\u{1b}[1m-16_Tinkering_with_CLI.typ\u{1b}[0m \u{1b}[1m(\u{1b}[0m\u{1b}[1;32m160\u{1b}[0m\u{1b}[32m addi…\u{1b}[0m\u{1b}[38;2;62;64;54m ▁\u{1b}[0m
\u{1b}[38;2;39;40;34;48;2;13;15;11m╲ \u{1b}[0m\u{1b}[2;48;2;13;15;11m@@ \u{1b}[0m\u{1b}[1;2;31;48;2;13;15;11m-200\u{1b}[0m\u{1b}[2;31;48;2;13;15;11m,\u{1b}[0m\u{1b}[1;2;31;48;2;13;15;11m6\u{1b}[0m\u{1b}[2;48;2;13;15;11m \u{1b}[0m\u{1b}[2;32;48;2;13;15;11m+\u{1b}[0m\u{1b}[1;2;32;48;2;13;15;11m200\u{1b}[0m\u{1b}[2;32;48;2;13;15;11m,\u{1b}[0m\u{1b}[1;2;32;48;2;13;15;11m15\u{1b}[0m\u{1b}[2;48;2;13;15;11m \u{1b}[0m\u{1b}[2;48;2;13;15;11m@@ Reinstalling packages \u{1b}[0m\u{1b}[1;2;48;2;13;15;11m(\u{1b}[0m\u{1b}[2;48;2;13;15;11mneeded python version upgrades. Ex: \u{1b}[0m\u{1b}[1;2;36;48;2;13;15;11m3…\u{1b}[0m\u{1b}[38;2;39;40;34;48;2;13;15;11m ╲\u{1b}[0m
\u{1b}[1;38;2;227;227;221;48;2;39;40;34m  \u{1b}[0m\u{1b}[38;2;101;102;96;48;2;39;40;34m200 \u{1b}[0m\u{1b}[2;38;2;149;144;119;48;2;39;40;34m  \u{1b}[0m\u{1b}[48;2;39;40;34mpipx reinstall-all\u{1b}[0m\u{1b}[48;2;39;40;34m                 \u{1b}[0m\u{1b}[1;38;2;227;227;221;48;2;39;40;34m  \u{1b}[0m\u{1b}[38;2;101;102;96;48;2;39;40;34m200 \u{1b}[0m\u{1b}[2;38;2;149;144;119;48;2;39;40;34m  \u{1b}[0m\u{1b}[48;2;39;40;34mpipx reinstall-all\u{1b}[0m\u{1b}[48;2;39;40;34m                 \u{1b}[0m
\u{1b}[1;38;2;227;227;221;48;2;39;40;34m  \u{1b}[0m\u{1b}[38;2;101;102;96;48;2;39;40;34m201 \u{1b}[0m\u{1b}[2;38;2;149;144;119;48;2;39;40;34m  \u{1b}[0m\u{1b}[48;2;39;40;34m```\u{1b}[0m\u{1b}[48;2;39;40;34m                                \u{1b}[0m\u{1b}[1;38;2;227;227;221;48;2;39;40;34m  \u{1b}[0m\u{1b}[38;2;101;102;96;48;2;39;40;34m201 \u{1b}[0m\u{1b}[2;38;2;149;144;119;48;2;39;40;34m  \u{1b}[0m\u{1b}[48;2;39;40;34m```\u{1b}[0m\u{1b}[48;2;39;40;34m                                \u{1b}[0m
\u{1b}[1;38;2;227;227;221;48;2;39;40;34m  \u{1b}[0m\u{1b}[38;2;101;102;96;48;2;39;40;34m202 \u{1b}[0m\u{1b}[48;2;39;40;34m])\u{1b}[0m\u{1b}[48;2;39;40;34m                                   \u{1b}[0m\u{1b}[1;38;2;227;227;221;48;2;39;40;34m  \u{1b}[0m\u{1b}[38;2;101;102;96;48;2;39;40;34m202 \u{1b}[0m\u{1b}[48;2;39;40;34m])\u{1b}[0m\u{1b}[48;2;39;40;34m                                   \u{1b}[0m
\u{1b}[38;2;39;40;34;48;2;13;15;11m╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲\u{1b}[0m\u{1b}[1;38;2;227;227;221;48;2;33;72;28m  \u{1b}[0m\u{1b}[38;2;132;208;130;48;2;33;72;28m203 \u{1b}[0m\u{1b}[48;2;33;72;28mReinstalling packages (needed python \u{1b}[0m
\u{1b}[38;2;39;40;34;48;2;13;15;11m╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲\u{1b}[0m\u{1b}[1;38;2;227;227;221;48;2;33;72;28m  \u{1b}[0m\u{1b}[38;2;132;208;130;48;2;33;72;28m204 \u{1b}[0m\u{1b}[48;2;33;72;28m#terminal([\u{1b}[0m\u{1b}[48;2;33;72;28m                          \u{1b}[0m
\u{1b}[38;2;39;40;34;48;2;13;15;11m╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲\u{1b}[0m\u{1b}[1;38;2;227;227;221;48;2;33;72;28m  \u{1b}[0m\u{1b}[38;2;132;208;130;48;2;33;72;28m205 \u{1b}[0m\u{1b}[2;38;2;149;144;119;48;2;33;72;28m  \u{1b}[0m\u{1b}[48;2;33;72;28m```sh\u{1b}[0m\u{1b}[48;2;33;72;28m                              \u{1b}[0m
\u{1b}[38;2;39;40;34;48;2;13;15;11m╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲\u{1b}[0m\u{1b}[1;38;2;227;227;221;48;2;33;72;28m  \u{1b}[0m\u{1b}[38;2;132;208;130;48;2;33;72;28m206 \u{1b}[0m\u{1b}[2;38;2;149;144;119;48;2;33;72;28m  \u{1b}[0m\u{1b}[48;2;33;72;28mpipx install ansible ansitoimg blac\u{1b}[0m
\u{1b}[38;2;39;40;34;48;2;13;15;11m╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲\u{1b}[0m\u{1b}[1;38;2;227;227;221;48;2;33;72;28m  \u{1b}[0m\u{1b}[38;2;132;208;130;48;2;33;72;28m207 \u{1b}[0m\u{1b}[2;38;2;149;144;119;48;2;33;72;28m  \u{1b}[0m\u{1b}[48;2;33;72;28m```\u{1b}[0m\u{1b}[48;2;33;72;28m                                \u{1b}[0m
\u{1b}[38;2;39;40;34;48;2;13;15;11m╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲\u{1b}[0m\u{1b}[1;38;2;227;227;221;48;2;33;72;28m  \u{1b}[0m\u{1b}[38;2;132;208;130;48;2;33;72;28m208 \u{1b}[0m\u{1b}[48;2;33;72;28m])\u{1b}[0m\u{1b}[48;2;33;72;28m                                   \u{1b}[0m
\u{1b}[38;2;39;40;34;48;2;13;15;11m╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲\u{1b}[0m\u{1b}[1;38;2;227;227;221;48;2;33;72;28m  \u{1b}[0m\u{1b}[38;2;132;208;130;48;2;33;72;28m209 \u{1b}[0m\u{1b}[48;2;33;72;28m                                     \u{1b}[0m
\u{1b}[38;2;39;40;34;48;2;13;15;11m╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲\u{1b}[0m\u{1b}[1;38;2;227;227;221;48;2;33;72;28m  \u{1b}[0m\u{1b}[38;2;132;208;130;48;2;33;72;28m210 \u{1b}[0m\u{1b}[48;2;33;72;28m                                     \u{1b}[0m
\u{1b}[38;2;39;40;34;48;2;13;15;11m╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲\u{1b}[0m\u{1b}[1;38;2;227;227;221;48;2;33;72;28m  \u{1b}[0m\u{1b}[38;2;132;208;130;48;2;33;72;28m211 \u{1b}[0m\u{1b}[48;2;33;72;28m                                     \u{1b}[0m
\u{1b}[1;38;2;227;227;221;48;2;39;40;34m  \u{1b}[0m\u{1b}[38;2;101;102;96;48;2;39;40;34m203 \u{1b}[0m\u{1b}[48;2;39;40;34m                                     \u{1b}[0m\u{1b}[1;38;2;227;227;221;48;2;39;40;34m  \u{1b}[0m\u{1b}[38;2;101;102;96;48;2;39;40;34m212 \u{1b}[0m\u{1b}[48;2;39;40;34m                                     \u{1b}[0m
")
])

== gita
Manage multiple git repos with sanity
#terminal([
  ```sh
  gita add -a ~/repos
  gita fetch
  gita ll
  ```
  #render("
learnGitBranching                               \u{1b}[37mmaster     [∅]    \u{1b}[0m Merge pull request #364 from
learnxinyminutes-docs                           \u{1b}[33mmaster     [?↓]   \u{1b}[0m Merge pull request #2162 from
PyConES-2014                                    \u{1b}[32mmaster     [?]    \u{1b}[0m Merge pull request #1 from
charla_anki_xonsh                               \u{1b}[32mmain       [?]    \u{1b}[0m 🍱 add media (1 year, 2 months
charla_pyvideo/my_talk_dir                      \u{1b}[37mmaster     [?∅]   \u{1b}[0m Adding slides html (8 years
charlas                                         \u{1b}[35mmain       [*+?↑] \u{1b}[0m 2024-11-13_lightning_gita (19
charlas_python_vigo                             \u{1b}[32mmaster     [$]    \u{1b}[0m Merge pull request #60 from
checkio-solutions                               \u{1b}[32mmaster     [?]    \u{1b}[0m ✨ ip-network-route-
coding_train                                    \u{1b}[35mmain       [*+?↑] \u{1b}[0m 🙈 Add .gitignore (1 year, 5
crafters/Racing-Car-Katas                       \u{1b}[32mmain       [?]    \u{1b}[0m Merge pull request #79 from
danipardo_puzznic                               \u{1b}[33mmaster     [↓]    \u{1b}[0m OSD: Display level and time
hyperos-debloat                                 \u{1b}[32mmain       [*?]   \u{1b}[0m first commit (5 months ago)
iniciacion_a_python_pyday_2017                  \u{1b}[33mmaster     [?↓]   \u{1b}[0m Actualizar atribuciones (8
lightning_better_exceptions                     \u{1b}[32mmaster     [?]    \u{1b}[0m Fix date (7 years ago)
lightning_loguru                                \u{1b}[33mmaster     [↓]    \u{1b}[0m Initial commit (6 years ago)
lightning_notebook_ansible                      \u{1b}[32mmaster     []     \u{1b}[0m Add .gitignore (6 years ago)
mineysocket                                     \u{1b}[37mmain       [?∅]   \u{1b}[0m Snapshot (6 months ago)
pyvideo/data                                    \u{1b}[32mmaster     [?]    \u{1b}[0m Merge pull request #1027 from

")

])

== pre-commit
A framework for managing and maintaining multi-language pre-commit hooks.
#terminal([

  ```sh
  cd repo_to_check
  zed .pre-commit-config.yaml
  pre-commit run --all-files
  ```
])

== pre-commit (config-file)
#terminal([
  #set text(size: 15pt)
  ```yaml
  # $REPO_ROOT/.pre-commit-config.yaml
  repos:
    - repo: https://github.com/pre-commit/pre-commit-hooks
      rev: v5.0.0
      hooks:
        - id: check-merge-conflict
        - id: check-xml
        - id: check-symlinks
        - id: check-toml
        - id: check-json
        - id: check-illegal-windows-names
        - id: check-added-large-files
        - id: check-yaml
          # args: [--unsafe] # Needed for ansible vault
        - id: check-ast
        - id: pretty-format-json
        - id: end-of-file-fixer
    - repo: https://github.com/astral-sh/ruff-pre-commit
      rev: v0.8.4
      hooks:
        - id: ruff
        - id: ruff-format
  ```
])
== And much more...
=== mdformat
CommonMark compliant Markdown formatter.

=== copier
A library for rendering project templates.


=== black
The uncompromising code formatter.

=== isort
A Python utility / library to sort Python imports.

=== mypy
Optional static typing for Python

=== ruff
An extremely fast Python linter and code formatter, written in Rust.

=== uv
An extremely fast Python package and project manager, written in Rust.

=== pytest
simple powerful testing with Python

=== pyupgrade
A tool to automatically upgrade syntax for newer versions.

=== datasette
An open source multi-tool for exploring and publishing data

=== jupyterlab
JupyterLab computational environment

=== streamlit
A faster way to build and share data apps

=== visidata
terminal interface for exploring and arranging tabular data

=== llm
A CLI utility and Python library for interacting with Large Language Models, including OpenAI, PaLM and local models installed on your own machine.

=== yt-dlp
A feature-rich command-line audio/video downloader

=== lightnovel-crawler
An app to download novels from online sources and generate e-books.

=== ansitoimg
Convert an ANSI string to an image. Great for adding terminal output into a readme.

=== lektor
A static content management system.

=== markdown-anki-decks
A command line program to convert markdown files into anki decks.

=== pyxel
A retro game engine for Python
