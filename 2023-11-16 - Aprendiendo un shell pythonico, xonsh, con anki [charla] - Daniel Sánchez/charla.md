% Aprendiendo un shell pythonico, xonsh, con anki
% Daniel Sánchez
% 16 de Noviembre, 2023

# ¿Quién soy yo?

- 🧔🏻 Daniel Sánchez
- Integrante de Python Vigo
- Administrador de sistemas
- pyvideo.org, pycon-es 2024

# Introducción

- **Anki**: Aplicación de estudio basada en tarjetas
  - [https://apps.ankiweb.net/](https://apps.ankiweb.net/)
- **Xonsh**: Lenguaje de shell basado en Python
  - [https://xon.sh](https://xon.sh)

## Causa de la charla

- Buscar herramientas (libres) de estudio para mi hija (tablet/chromebook)
- Anki como aplicación para estudiar
- Tomar de mi propia medicina con algo que quería aprender: Xonsh

## Porqué en Python Vigo

- Xonsh: Python en el shell
- Anki: Somos "knowledge workers"

# Anki

- Tarjetas con pregunta/respuesta
- Repetición espaciada: [https://ncase.me/remember](https://ncase.me/remember)

## Repetición espaciada

- Se basa en la `curva del olvido` propuesta por `Hermann Ebbinghaus`(1885).
- Consiste en repasar en intervalos espaciados para maximizar $memorización/esfuerzo$.
- Intervalos cada vez más largos para reducir tiempo de estudio y aumentar retención a largo plazo.
- La tarjeta que olvidas vuelve al intervalo más corto.

## Anki - Aplicación

- Multiplataforma
- Las tarjetas se agrupan en mazos (grupos, subgrupos, ...)
- Puedes exportarlos a fichero o a la web de Anki

## Creación de tarjetas - Fichero

`~/ejemplo.md`
``` sh
# IT::Xonsh

## Crear una variable de entorno en xonsh

`$X = 1`
```

## Creación de tarjetas - *.apkg

``` sh
pip install markdown-anki-decks
mkdir input/ output/
cp ~/ejemplo.md input/ejemplo.md
mdankideck input/ output/ # Crea output/ejemplo.apkg
```

`ejemplo.apkg` es el mazo de tarjetas (deck) a cargar en anki

## Muestra de tarjeta

![Imagen de tarjeta de Anki](media/anki.jpg)

## markdown-anki-decks

- Pros
  - Sencillo y efectivo
  - Soporta imagen y sonido (importante para estudiar idiomas)
- Contras
  - Modificar equivale a crear una pregunta distinta
  - El mantenedor creó una startup y ya no responde

## Consejos para crear tarjetas

- Tu yo futuro no ha de decir: 🚽🪠💩💥🤬
  - ¿Que me pregunta?
  - Se cosas de la pregunta ¿Porqué no me dice en concreto lo que quiere?
  - No me dice ni cuantas ni cuales. Pense tres apartados, pero eran 4.
- La pregunta ha de guiar a una respuesta concreta

## Nunca apetece estudiar

- Adaptarlo a tu propia experienecia (Iterar)
  - Preparar las preguntas ya es aprender
  - Ver cuantas preguntas al día
  - Podar o reescribir lo que no convenza o ya no haga falta
  - Compartimentar en submódulos

# Xonsh

- Shell script mezcla de python y bash
- No poner como default shell del usuario, sino del terminal.

## Pros

- Python
- Prompt: Historial, Syntax highlighting, Tab completion
- Globs: Clásico, python (\*\*), regexp (\`\`)
- Cross-platform, ...

## Contras

- Utiliza más recursos que bash (180M vs 5M)
- No es posix compliant
- Añade sintaxis que no es ni bash ni python

## Instalación

``` sh
python3 -m ensurepip --upgrade
python3 -m pip install --upgrade pip pipx
pipx install "xonsh[full]"
# Si solo quieres probar:
podman run -it --rm docker.io/xonsh/interactive
```

xfce4-terminal → (Menú) Editar → Preferencias
 → General → Orden personalizada

## Modo subproceso

``` sh
ls -l
```
```
foo bar baz
```

``` sh
ls /proc/ | grep b | tr '\n' ' '
```
```
bootconfig buddyinfo bus dynamic_debug fb slabinfo
```

## Modo python

``` py
2**12345
```

```
16417101068825821635602074166390650141012723553073588127211610308792509417139014
42801590345364394577348704191271404016671955103310856571853327210892364011930444
93457116299768844344303479235489462436380672117015123283299131391904179287678259
17330853673876198113995865488085223490844833881728901416677416986925133937982859
97484929187754378647390322177780513338829900741162462812693649337248923421345047
02491040016637557429810893780765197418589477584716543480995722533317862352141459
21778131626621118648615701926208041407767026464273601842699811352344573268085614
43298769722733007033925849977292071979710839457003454940924001471869973070120694
54068489589035676979448169848060836924945824197706493306108258511936030341393221
58642352326445244940378199335242188509466405227079552763272189612142481317352247
46743958861550922034040367307484747817107157454461354680981398318240832596479191
75273503681561172684624283384438504776503000432241604550454374116320822227191911
32212348408506392635060634219714640784117802807114719253394251727055351398814292
59760907696954562211596990525835330113316520793470930981730869754835392744640233
57456484465482927479569437320368592222760278170306076733438801098370797675711274
67105497071144215893056168434313577411874159450670283314739675882501585004298334
36903451859959562351438257716205435460306645626478546564313026445741198738202155
95718618624485232422006575550007068883734241454686368856734496265385908809403972
49468513774112286689671967805393728581840975167032014050184303922404073587009688
95962734191063891036620953189379906259801367119882374219623152666868560895059814
38440850638067589321141759499017023839596858455548192000140085142294166987063499
02479268133484315979093632135191985975866956920054150761209978090970519890217602
62198722017154220960903436862729843514415945695067780410626632667993427938563138
01540959815845788584759033248828248561586450271172777240971795656082001848115815
26093052166316748017388606401911857277828151673515777955588816778706443255859541
08439874464978816662884232331700604130259246299504773033421801493989260736185827
15358742250388958231281694757980523791263699450732952325727664209947786063982561
77532763850451691857010131939169841238860760374248441474826838966912911802687896
97357822868411168426564105746476075244189007203280453779933862798087689903762894
24757351052369393977137871998119168898493037938756635621557623138404459266598837
78422932579983878202606048149686556175703183900225709180287694924839274417566911
22420884398832483363105970012573859807769615293511988777471935310549568818083321
77946751404038228718567911769630971553915410012677600002457982207465176670752102
11700277398054808969653097247643969459988128181297321726585388472790653547974585
40853388511051445854819941562064974367458999448777325314125412790143003245948906
23941145509856940982863769834430048120562966797907114102689879364945689860493474
95453842236771950788251316605100735299406831925145066667664836820056432938299875
88757604142596540049772613099882673198063548560517845539909366106347333759841590
28722378614984450255386315585631994503350002142910493190254825610707400589976364
98574846795513107797164188267289585457123636828281133622076917478472011333126908
47465242041242634750541128416309335861661950361156964696860756004804205635575676
16835633252622327172811002146392754445051182169805284630259703542633955126179520
11305962991422983368853592572967677802840689731610610103846911909098456715259196
23654150396463945915038307976263392469860570777586114136649141687453752667862981
41171496573941614387744125843685677063619782918759823106021054037757857761587472
24083504058044736054402906493041256994316972923810216231221868793020306805540027
5795180972382856696655279408212344832
```

## Modo python

``` py
import sys
sys.version
```
```
'3.12.0 (main, Oct  2 2023, 00:00:00) [GCC 13.2.1 20230918 (Red Hat 13.2.1-3)]'
```

## Modo python

(En Xonsh) Python siempre gana :)

``` py
ls, l = 68,26
ls -l
```

```
42
```

``` py
del ls, l
```

## Variables de entorno (modo subproceso)

``` sh
$HOME
# Específico de Xonsh
expresion_python = "HOME"
${expresion_python}
${...}
```

## Truco. Pedir clave y que solo sea accesible en un bloque with

``` sh
import getpass
with ${...}.swap(PASS=getpass.getpass()):
  echo $PASS
```

## Usando shell dentro de python

``` sh
$(comando) ; !(comando) # Capturando stdout
$[comando] ; ![comando] # Sin capturar stdout
```

## Usando python dentro de shell

``` sh
${expresion_python} # Stdout como nombre de variable
@(expresion_python) # La salida se usa como un token o una lista de tokens
```

## Usando shell dentro de shell, pasando por python

``` sh
@$(comando) # La salida del comando da otro comando, que es ejecutado
```

## Ejemplo

``` py
for x in list(set($(man bash).split()))[:300]:
    if x.isalnum():
        touch @(x)
```

## Anidando subprocesos

``` sh
echo @("file." + $(date -I).strip() + ".bak")
```

## Strings avanzados

| Nativo | Icono   | Transformación                    |
| ------ | ------- | --------------------------------- |
| 🐍     | \\      | Backslash escapes                 |
| 🐍     | 🔄 {}   | Sustituye expresiones entre {}    |
| 🐚     | 🔄 $VAR | Sustituye $VAR en modo subproceso |
| 🐚     | /       | Devuelve un pathlib.Path          |

## Strings avanzados

| String   | Tipo                    |
| -------- | ----------------------- |
| `  ""`   | 🐍regular string        |
| ` r""`   | 🐍raw string            |
| ` f""`   | 🐍formatted string      |
| `fr""`   | 🐚raw formatted string  |
| ` p""`   | 🐚path string           |
| `pr""`   | 🐚raw Path string       |
| `pf""`   | 🐚formatted Path string |

## Strings avanzados

| String   | \    | 🔄 $VAR | 🔄 {} | /path |
| -------- | ---- | ------- | ----- | ----- |
| `  ""`   | ✅   | ✅      | ❌    | ❌    |
| ` r""`   | ❌Ⓡ  | ❌Ⓡ     | ❌    | ❌    |
| ` f""`   | ✅   | ✅      | ✅Ⓕ   | ❌    |
| `fr""`   | ❌Ⓡ  | ❌Ⓡ     | ✅Ⓕ   | ❌    |
| ` p""`   | ✅   | ✅Ⓟ     | ❌    | ✅Ⓟ   |
| `pr""`   | ❌Ⓡ  | ✅Ⓟ     | ❌    | ✅Ⓟ   |
| `pf""`   | ✅   | ✅Ⓟ     | ✅Ⓕ   | ✅Ⓟ   |

## Globs

| Representación | Tipo de glob          |
| -------------- | --------------------- |
| `*`            | Shell glob            |
| `**`           | Python glob           |

## Globs

| Representación           | Tipo de glob          |
| ------------------------ | --------------------- |
| ``` ``   ```             | Regexp glob           |
| ``` f``  ```             | Formatted regexp glob |
| ``` p``  ```             | Path regexp glob      |
| ``` g``  ```             | Shell glob            |
| ``` fg`` ```             | Formatted shell glob  |
| ``` pg`` ```             | Path shell glob       |
| ``` @<func_name>`test` ``` | Custom glob           |

## Help → ?

Ayuda de objetos y métodos de python
``` sh
"".join ? # Muestra help(join)
aliases['showcmd'] ?? # Muestra ayuda y fuente
```

## aliases

```py
aliases['piu'] = 'pip install -U @($args)'
```

# Bill of materials

- Pandoc:
``` sh
pandoc --standalone --mathjax --slide-level 2 --write=revealjs \
  charla.md --output=charla.html
```
- Reveal.js
- Xonsh
- Anki
- markdown-anki-decks
- fedora kinoite
