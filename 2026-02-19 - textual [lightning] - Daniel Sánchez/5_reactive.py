# reactive_demo.py
from textual.app import App, ComposeResult
from textual.widgets import Header, Footer, Button, Static
from textual.containers import Container
from textual.reactive import reactive
import time

class Counter(Static):
    """Widget reactivo que se actualiza solo"""
    count = reactive(0)

    def watch_count(self, old: int, new: int) -> None:
        """Se ejecuta automáticamente cuando count cambia"""
        self.update(f"Contador: {new}")

class ReactiveApp(App):
    CSS_PATH = "5_reactive.tcss"

    def compose(self) -> ComposeResult:
        yield Header()
        with Container():
            yield Counter("Contador: 0", id="display")
            with Container(classes="botones"):
                yield Button("-1", id="menos", variant="error")
                yield Button("+1", id="mas", variant="success")
                yield Button("Reset", id="reset")
        yield Footer()

    def on_button_pressed(self, event: Button.Pressed) -> None:
        counter = self.query_one("#display", Counter)
        if event.button.id == "mas":
            counter.count += 1
        elif event.button.id == "menos":
            counter.count -= 1
        elif event.button.id == "reset":
            counter.count = 0

if __name__ == "__main__":
    app = ReactiveApp()
    app.run()
