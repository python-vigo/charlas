#import "@preview/touying:0.5.4": *
#import themes.metropolis: *

// Conjuro para mostrar el logo de LaTeX
#import "@preview/metalogo:1.0.2": LaTeX
#show "LaTeX": LaTeX

// Personalizar fuente
#set text(
  lang: "es", // Ortografía en castellano
  region: "es",
  font: "Lato",
  // size: 20pt
)
// Enlaces en azul
#show link: it => [#set text(blue); #it]

#let ejemplo(fuente:"", visualizacion: none) = {
  // If visualizacion is not provided, use fuente
  let vis = if visualizacion == none {
    eval(fuente, mode: "markup")
  } else {
    visualizacion
  }

  grid(
    columns: (1fr, 1fr),
    gutter: 10pt,
    align(top + left)[
      #block(
        width: 100%,
        height: 85%,
        fill: silver,
        inset: 8pt,
        radius: 4pt,
        raw(
          lang: "typst",
          fuente
        )
      )
    ],
    align(top + left)[
      #box(
        width: 100%,
        height: 85%,
        fill: white,
        inset: 8pt,
        radius: 4pt,
        stroke: (
          paint: gray.lighten(50%),
          thickness: 1pt,
          dash: "solid"
        ),
        [#vis]
      )
    ]
  )
}


// Tema
#show: metropolis-theme.with(aspect-ratio: "16-9")
// Diapositiva inicial
#show: metropolis-theme.with(
  aspect-ratio: "16-9",
  footer: self => self.info.institution,
  config-info(
    title: [Introducción a Typst],
    subtitle: [Maquetando documentos programáticamente],
    author: [🧔🏻 Daniel Sánchez],
    date: datetime.today(),
    institution: [Python Vigo],
    logo: emoji.snake,
  ),
)
#title-slide()

// Presentación
== ¿Qué es Typst?

- Lenguaje de marcado para crear documentos
- Alternativa moderna a LaTeX
  - Más simple
  - Mayor rapidez en compilación
- Escrito en Rust
- Licencia Apache 2.0

== Disponibilidad (Terminal)
- Fuente https://github.com/typst/typst
- Librería https://pypi.org/project/typst
- Instalación:
  ```sh
  # CLI
  cargo install --locked typst-cli
  # Librería standalone
  pip install typst
  ```

== Disponibilidad (GUI)

- GUI con ventanas de edición y visualización
  - Plugin LSP Tinymist (Vscode) → Apache 2.0
  - https://typst.app/ → 🪙 Servicio para financiarse
    - Free: Editor colaborativo, alojamiento en la nube
    - Pro: Slides, GitHub/GitLab, reviews, ...

== Python

Para crear .pdf, .png o .svg a partir de .typ
```py
import typst
typst.compile("hello.typ", output="hello.pdf")
typst.compile("hello.typ", output="hello.png", format="png", ppi=144.0)
pdf_bytes = typst.compile("hello.typ")
svg_bytes = typst.compile("hello.typ", format="svg")
```


== Sintaxis básica

#ejemplo(fuente:
"// Comentario
/* Comentario de bloque */
= Título
== Sintaxis básica (Markup)

Párrafo de texto normal.

- Lista
- Elemento
  - subelemento
    + sub-subelemento numerado
")

== Sintaxis básica (Markup)

#ejemplo(fuente:
"- _Cursiva_.
- *Negrita*.
- _*Negrita cursiva*_.

`print(\"raw text\")`

```py
print('Python!')
```
")

== Sintaxis básica (Matemáticas)
#ejemplo(fuente:
"// formato: $Ecuación$
En línea $e = m c^2$ (← en medio)

Fuera de línea $
7.32 beta + sum_(i=0)^nabla
(Q_i (a_i - epsilon)) / 2
$
Varias ecuaciones $
// Alineadas con &
v &:= vec(x_1, x_2, x_3) \
cal(A) &arrow.squiggly bb(B)
$
")

== Sintaxis básica (Código)
#ejemplo(fuente: "// El código tiene el prefijo #
#let fibonacci(n) = {
  let a = 0
  let b = 1
  let seq = (a, b)
  while seq.len() < n {
    seq.push(a + b)
    (a, b) = (b, a + b)
  }
  seq
}

#fibonacci(10)
")
== Sintaxis básica (Imágenes)
#ejemplo(fuente: "
#image(\"logo.png\",  // archivo local
     width: 2cm) // '2in', '70%', ...
#figure( // con título centrada
  image(\"logo.png\", width: 10%),
  caption: [ // markup entre []
    Logo oficial],
) <my_label> // <Etiqueta>

Referencia a @my_label // @referencia
")

== Formato de página
#ejemplo(fuente:
"
#set page( // Sets page layout. If different → new page
  paper: \"a4\",
  margin: (x: 1.8cm, y: 1.5cm),
  flipped: true, // Landscape
)
", visualizacion: [
No hay minidemo posible

#set text(
  size: 80pt,
)
  #emoji.person.facepalm
] )

== Formato
#ejemplo(fuente: "
#set text(
  font: \"New Computer Modern\",
  size: 30pt,
  lang: \"en\", // spelling in English
  region: \"us\",
)
#set par(
  justify: true,
  leading: 0.52em, // 1em == font size
)
#lorem(30)
")

== Enlaces

Hay mucho más, pero no entra en una #emoji.lightning
