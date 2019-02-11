## Code 

## Example 1 ##

class Muggle:
	def __init__(self, tech):
		self.tech = tech

	def __str__(self):
		return 'Normal guy with tech %s' % self.tech

	def __repr__(self):
		return 'Muggle(%s)' % self.tech


class Wizard:
	def __init__(self, animagus, seer):
		self.animagus = animagus
		self.seer = seer

	def __str__(self):
		return 'Good magician! Can transform in {}'.format(self.animagus)

	def __repr__(self):
		return 'Wizard({}, {})'.format(self.animagus, self.seer)

class Sorcerer:
	def __str__(self):
		return 'Very bad guy'
	def __repr__(self):
		return 'Sorcerer()'


class Squib:
	def __str__(self):
		return 'Wizard-born Muggle'
	def __repr__(self):
		return 'Squib()'

me = Muggle(1)
harry = Wizard('dog', True)
hermione = Wizard('cat', False)
print(me)
Normal guy with tech 1
magicians = [harry, hermione]
print(magicians)
[Wizard(dog, True), Wizard(cat, False)]


## Example 2 ##

class Muggle:
	def __getattr__(self, name):
		return 'I don´t have attr %s!' % name

mugg = Muggle()
mugg.tech
'I don´t have attr tech!'
mugg.tech = 9
mugg.tech
9
mugg.__dict__.popitem()
('tech', 9)
mugg.tech
'I don´t have attr tech!

## Example 3 ##

class Muggle:
	def __init__(self, tech=None):
		self.tech = tech

	def __getattr__(self, name):
		return 'I don´t have attr %s!' % name

	def __getattribute__(self, name):
		print('My attr: ', name)
		if name == 'tech':
			return object.__getattribute__(self, name)
		else:
			raise AttributeError

mugg = Muggle()
mugg.tech
My attr:  tech
mugg.tech = 2
mugg.tech
My attr:  tech
2
mugg.whatever
My attr:  whatever
'I don´t have attr whatever!'

## Example 4 ##

class PoweredWizard:
    """Proxy to the object."""
    writeable_fields = ['animagus']
    logging_fields = []

    def __init__(self, wizard, logger=None):
        self._wizard = wizard
        self.logger = logger

    def __eq__(self, other_wizard):
        other_wizard = getattr(other_wizard, '_wizard', other_wizard)
        return self._wizard == other_wizard

    # Delegate attribute lookup to wizard object
    def __getattr__(self, name):
        return getattr(self._wizard, name)

    # Assign attribute to internal obj if in fields
    def __setattr__(self, name, value):
        if name in self.writeable_fields:
            old_value = getattr(self, name)

            setattr(self._wizard, name, value)

            if name in self.logging_fields:
                self.logger.notify(name, old_value, value)
        else:
            # Regular access to self properties
            super().__setattr__(name, value)

    def __str__(self):
        return self._wizard.__str__()

    def get_object(self):
        """Return proxied object."""
        return self._wizard

>>> harry
Wizard(dog, True)
>>> harry_pw = PoweredWizard(harry)
>>> dir(harry_pw)
['__class__', '__delattr__', '__dict__', '__dir__', '__doc__', '__eq__', '__format__', '__ge__', '
__getattr__', '__getattribute__', '__gt__', '__hash__', '__init__', '__le__', '__lt__', '__module_
_', '__ne__', '__new__', '__reduce__', '__reduce_ex__', '__repr__', '__setattr__', '__sizeof__', '
__str__', '__subclasshook__', '__weakref__', '_wizard', 'get_object', 'logger', 'logging_fields',
'writeable_fields']
>>> harry_pw.animagus
'dog'
>>> harry_pw.seer
True
>>> harry_pw.animagus = 'cat'
>>> harry_pw.animagus
'cat'
>>> harry.animagus
'cat'
>>> harry_pw.seer
True
>>> harry_pw.seer = False
>>> harry_pw.seer
False
>>> harry.seer
True
>>> harry2 = Wizard('wolf', False)
>>> harry
Wizard(cat, True)
>>> harry3 = Wizard('cat', True)
>>> harry_pw1 = PoweredWizard(harry2)
>>> harry_pw1 == harry_pw
False
>>> harry_pw2 = PoweredWizard(harry3)
>>> harry_pw == harry_pw2
False
>>> harry_pw2._wizard = harry
>>> harry_pw == harry_pw2
True
