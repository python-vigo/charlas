#!/usr/bin/env bash
echo "
textual run 4_hello.py

textual run 4_widget.py
textual run 5_reactive.py


# Terminal 1 - Abrir DevTools
textual console

# Terminal 2 - Ejecutar app en modo dev
textual run --dev reactive_demo.py

mdquote.py


python -m textual
"
