// Packages
#import "@preview/touying:0.6.1": *
#import themes.metropolis: *

// Tema
#show: metropolis-theme.with(
  aspect-ratio: "16-9",
  footer: self => self.info.institution,
  config-info(
    title: [Welcome to TUI!],
    subtitle: [Textual, Not Just Another CLI],
    author: [#text(font: "Noto Color Emoji")[🧔🏻]Daniel Sánchez],
    date: "🗓️ 2026-02-19",
    institution: [#text(font: "Noto Color Emoji")[🐍] Python Vigo],
    logo: [💻],
  ),
)
#title-slide()

// --- SLIDES ---

#slide[
  == The CLI Problem

  Why do our terminal tools look so... "retro"?

  - *Scripting:* `input()` and `print()` are extremely limited.
  - *Old School TUIs:* `curses` and `ncurses` are powerful, but...
    - Hard to learn.
    - Prone to errors.
    - Ugly and rigid interfaces.

  #v(0.5em)

  #quote(block: true)[The terminal deserves modern interfaces.]
]

#slide[
  == The Solution: Textual

  Textual is a Python framework for building *Text User Interfaces (TUIs)*.

  - Created by *Will McGugan* (also creator of `Rich` and `Pygmentize`).
  - Fast and Asynchronous.
  - *The Big Idea:* Bringing modern Web Development concepts to the terminal.
]

#slide[
  == Key Concept: The Web Analogy

  If you know Web Development, you already know Textual.

  #block(inset: (left: 2em))[
    #table(
      columns: (auto, auto),
      align: (center, center),
      [*Web Tech*], [*Textual (Terminal)*],
      [HTML (Structure)], [Widgets (Components)],
      [CSS (Style)], [CSS (Style)],
      [DOM (Element Tree)], [Widget Tree],
      [JavaScript (Events)], [Messages],
    )
  ]
]

#slide[
  == Widgets: The Building Blocks

  Everything in Textual is a *Widget*.

  - `Static`: Simple or formatted text.
  - `Button`: Interactive buttons.
  - `Input`: Text entry fields.
  - `Container`: Boxes to organize other widgets.

  #v(0.5em)

  ```python
  def compose(self) -> ComposeResult:
      yield Header()
      yield Container(
          Static("Hello World"),
          Button("Click me")
      )
      yield Footer()
  ```
]

#slide[
  == CSS: The Power of Layout

  Forget calculating coordinates `x, y`. Use *CSS* to design.

  ```css
  /* Defined as a string inside Python */
  Screen {
      align: center middle; /* Flexbox in the terminal! */
  }

  Container {
      border: solid green;
      padding: 1;
      width: auto;
  }
  ```
]

#slide[
  == Reactivity: The Python Magic

  Textual uses reactive variables. When data changes, the UI updates automatically.

  ```python
  from textual.reactive import reactive

  class Counter(Static):
      # Define a reactive variable
      count = reactive(0)

      def watch_count(self, old, new):
          # This runs automatically when count changes
          self.update(f"Total: {new}")
  ```
]

#slide[
  == Developer Experience (DevTools)

  Textual is not just a UI library; it's a professional environment.

  *The Correct Workflow:*

  1. *Terminal 1 (DevTools):*
     `textual console` #h(1em) // Typst syntax for space
     _Opens the visual inspector._

  2. *Terminal 2 (App):*
     `textual run --dev app.py`
     _Runs the app in dev mode._
]

#slide[
  == Why Use Textual?

  Real world applications:

  - *Server Dashboards:* Monitor logs, CPU, RAM.
  - *DevOps Tools:* Interfaces for Docker, Kubernetes, Git.
  - *Interactive CLIs:* Complex configuration forms.
  - *Games!* (Yes, it's possible).
]

#slide[
  == Summary

  1. *Easy:* Uses familiar concepts (CSS, Components).
  2. *Modern:* Async/Await, Hot Reloading, DevTools.
  3. *Useful:* Make your terminal scripts usable for humans.

  #v(1em)

  #text(weight: "bold", size: 1.2em)[Stop using `print()` for everything. Start building applications.]
]

#slide[
  == Resources

  - *Official Docs:* #link("https://textual.textualize.io")[textual.textualize.io]
  - *GitHub:* #link("https://github.com/Textualize/textual")[github.com/Textualize/textual]

]
