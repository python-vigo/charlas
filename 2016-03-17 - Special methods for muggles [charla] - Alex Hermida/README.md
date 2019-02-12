

## Intro

Presentation for [Python Vigo](https://www.python-vigo.es) user group in March 17, 2016.

Uses [Hovercraft](https://github.com/regebro/hovercraft) lib to execute slideshow

Code examples are in *examples.py* file. Are intended for execute in python console.

## Installation

1. Clone the repo:
	
	```
    $ git clone git@github.com:alexhermida/special-methods-for-muggles.git
    $ cd special-methods-for-muggles
    ```
  
2. Create a virtualenv with Python 3 and activate it
	
	```
	$ virtualenv -p python3 .venv
	$ source .venv/bin/activate
	```

3. Install dependencies
	
	```
   	$ pip install -r requirements.txt
   	```

3. Start the slideshow:

	```
    $ hovercraft index.rst
	```
