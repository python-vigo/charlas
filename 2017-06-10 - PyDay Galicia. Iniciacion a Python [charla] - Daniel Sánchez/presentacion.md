% Iniciación a Python!
% Daniel Sánchez
% 2017-05-18

## Quien soy

* Trayectoria
* ¿Por qués estoy aquí?

<div class="notes">
- Varios tipo de puestos y ahora Admin sistemas
- Automatización
- bash => perl => python
- Encuesta
    - Usado python
    - Programado algo, tutorial, programa útil (propio, ajeno), por dinero.
</div>

# Python

## Introducción
![](./figures/Guido_van_Rossum.png){width=10%}

* Guido Van Rossum (Benevolent Dictator For Life)
* Fan de los Monty **Python**
* Lenguage interpretado de propósito general
* Python 1.0 liberado en enero de 1994
* Versión actual Python3, manteniendo Python 2.7

## Características

* Centrado en:
    * Recoge las mejores características de otros lenguages
    * Facilidad de programacion
    * Legibilidad
    * Llama a lenguajes compilados si se necesita
        * C
        * Fortran
    * Batteries included
    * Comunidad

## Impacto

* Instalado por defecto en Linux, FreeBSD y Mac
* Multitud de ámbitos: Desarrollo web, Admin de sistemas, ámbito científico, GIS, Análisis de datos, IA, ...
* Más de 100.000 paquetes en PyPI (Indexador de paquetes)
    * Orientado a objetos

# Instalación

## Linux

~~~ bash
python3 -V
# Si no está instalado
sudo apt install python3
~~~

## [Windows](https://docs.python.org/3/using/windows.html#using-python-on-windows)

* En [www.python.org/downloads/](https://www.python.org/downloads/):
    * Escoger python3
    * Descargar Windows executable installer (64 bits)
    * Instalar

# Lenguage

## Demo python3
* Invocación del intérprete
    * Python
    * Ipython
    * Jupyter notebook

# Paquetes

## pip

~~~ bash
pip install ipython # Instala ipython
pip install --upgrade ipython # Actualiza ipython a la última versión
pip freeze > requirements.txt # Guarda un listado de paquetes y versiones
pip uninstall ipython # Desinstala ipython 
pip install --requirement requirements.txt # Instala los paquetesl del fichero
~~~  

## virtualenv

~~~ bash
python3 -m venv <DIR>
source <DIR>/bin/activate
# Usar los paquetes, instalarlos, desinstalarlos
deactivate # Si queremos salir del entorno
~~~

## virtualenvwrapper

**Linux**

~~~ bash
sudo apt get install virtualenvwrapper
# Salir y entrar de la consola
~~~

**Windows**

~~~ bat
pip install virtualenvwrapper-win
~~~

## comandos virtualenvwrapper

~~~ bash
# Crear entorno
which python3
mkvirtualenv --python=/usr/bin/python3 test

pip install ipython

deactivate # salir
lsvirttualenv # listar
workon test # Activar el entorno test
...
deactivate
rmvirtualenv test # Para borrarlo no podemos estar dentro
~~~

# Recursos

## Documentación
* Documentación oficial de Python  
  [https://www.python.org/doc](http://www.python.org/doc)
* Guı́a para principiantes  
  [https://wiki.python.org/moin/BeginnersGuide](http://wiki.python.org/moin/BeginnersGuide)
* Learn Python (Español)  
  [https://www.learnpython.org/es/](http://www.learnpython.org/es/)
* Traducción del manual de Guido van Rossum  
  [https://docs.python.org.ar/tutorial/pdfs/TutorialPython2.pdf](http://docs.python.org.ar/tutorial/pdfs/TutorialPython2.pdf)
* [How to Think Like a Computer Scientist: Interactive Edition](http://interactivepython.org/runestone/static/thinkcspy/index.html)

## Web

* Meetups:
    * [https://www.python-vigo.es/](https://www.python-vigo.es/)
    * [http://vigotech.org](http://vigotech.org)
* Videos de charlas: [https://pyvideo.org](https://pyvideo.org) (más de 7000)
* Resumen de sintaxis: [https://learnxinyminutes.com](https://learnxinyminutes.com/docs/es-es/python3-es/)
* Ejemplos de proyectos: [https://newcoder.io](https://newcoder.io)
* Podcasts:
    * [http://pythonbytes.fm/](http://pythonbytes.fm/)
    * [https://talkpython.fm/](https://talkpython.fm/)
    * [https://www.podcastinit.com/](https://www.podcastinit.com/)
    * [http://pythontesting.net/](http://pythontesting.net/)

# Atribuciones

## Imágenes

* Foto de Guido van Rossum:  [https://upload.wikimedia.org/wikipedia/commons/thumb/9/94/Guido_van_Rossum_OSCON_2006_cropped.png/250px-Guido_van_Rossum_OSCON_2006_cropped.png](https://upload.wikimedia.org/wikipedia/commons/thumb/9/94/Guido_van_Rossum_OSCON_2006_cropped.png/250px-Guido_van_Rossum_OSCON_2006_cropped.png)

## Software

* [Markdownreveal](https://github.com/markdownreveal/markdownreveal) (Diapositivas html)
* [Jupyter notebook](http://jupyter.org/)
* [Ipython](https://ipython.org/)


# Preguntas
