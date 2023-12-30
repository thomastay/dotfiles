# Custom functions that I use in the Python interpreter

from math import log, pow, sqrt

# x is a real number between 0 and 1, representing the return on a bond
def yld(x):
	return 1 + ( (1-x)/x)

def scifmt(x):
	return "{:.2e}".format(x)

def hufmt(x):
	return "{:,}".format(x)

def yldfmt(x):
	return "{:.2f}%".format(yld(x))
