#!/usr/bin/env python

# hello.py
from textual.app import App, ComposeResult
from textual.widgets import Header, Footer, Static

class HelloApp(App):
    """Primera app con Textual"""

    def compose(self) -> ComposeResult:
        yield Header()
        yield Static("¡Hola Python Vigo! 👋", classes="titulo")
        yield Footer()

if __name__ == "__main__":
    app = HelloApp()
    app.run()
