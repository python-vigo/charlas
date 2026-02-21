#!/usr/bin/env python

# widgets_demo.py
from textual.app import App, ComposeResult
from textual.widgets import Header, Footer, Button, Static, Input
from textual.containers import Container

class WidgetsDemo(App):
    CSS_PATH = "4_widget.tcss"  # Archivo CSS externo

    def compose(self) -> ComposeResult:
        yield Header()
        with Container():
            yield Static("Escribe tu nombre:", classes="label")
            yield Input(placeholder="Tu nombre aquí...", id="nombre")
            yield Button("¡Saludar! 🎉", id="saludar", variant="success")
            yield Static("", id="resultado")
        yield Footer()

    def on_button_pressed(self, event: Button.Pressed) -> None:
        if event.button.id == "saludar":
            nombre = self.query_one("#nombre", Input).value
            resultado = self.query_one("#resultado", Static)
            resultado.update(f"¡Bienvenido, {nombre or 'Anónimo'}!")

if __name__ == "__main__":
    app = WidgetsDemo()
    app.run()

