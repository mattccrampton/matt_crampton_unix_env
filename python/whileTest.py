#!/usr/bin/env python
from filecmp import dircmp
from subprocess import Popen, PIPE, STDOUT
import time
import sys
import os


def main():
	testResult = ""
	i=0
	while i < 10 and len(testResult)<1:
		i = i+1
		print "Testing connection attempt #%s" % (i)
		p = Popen("datex", shell=True, stdout=PIPE, stderr=PIPE)
		testResult, stderr = p.communicate()
		if len(testResult)<1:
			print stderr
		else:
			print testResult


if __name__ == "__main__":
	main()



