#!/usr/bin/env python
from filecmp import dircmp
from subprocess import Popen, PIPE, STDOUT
import time
import sys
import os

class ConsoleDialog():

	def __init__(self):
		self.TMPDFILE="/tmp/temp_dialog_666"

	def showMessage(self,title, enterToContinue=False):
		FULLCOMMAND = "clear; dialog --title \"\" --infobox \"\n%s\" 6 55;" % (title)
		if enterToContinue:
			FULLCOMMAND = "%s read XXX" % (FULLCOMMAND)

		DIALOGRESULT = os.system(FULLCOMMAND)

	def ShowDialog(self,title,options):

		SETA="dialog --clear --colors --title \"%s\" --menu \"Please select...\" 34 130 27 " % (title)

                SETB=" \"\" \"QUIT\" "


		for optionKey in sorted(options.iterkeys()):
			#print "%s: %s" % (key, mydict[key])
			#for optionKey in options:
			try:
				SETB="%s \"%s\" \"%s\" " % (SETB, optionKey.replace("\"",""), options[optionKey].replace("\"",""))
				SETB = unicode(SETB)
			except:
				print "Failed for %s" % (option)
				continue

                SETC=" \"\" \"QUIT\" "


		FULLCOMMAND="%s %s %s 2> %s" % (SETA, SETB, SETC, self.TMPDFILE)
		FULLCOMMAND= FULLCOMMAND.encode('utf-8')
		#print FULLCOMMAND

		DIALOGRESULT = os.system(FULLCOMMAND)
		if DIALOGRESULT != 0:
			return False

		FULLCOMMAND="cat %s" % (self.TMPDFILE)
		return os.popen(FULLCOMMAND).read()

class GnarleyDiffMerge():

	def __init__(self,dir1,dir2):
		self.stopwords=['css-concat','js-concat','.svn','.git','aws-sdk','.png','.jpg','.gif','css-min','js-min']

		self.CD = ConsoleDialog()
		self.dir1 = dir1
		self.dir2 = dir2

	def run(self):

		dcmp = dircmp(self.dir1, self.dir2)
		diffDict = self.generateDiffDict(dcmp) 

		print diffDict
		#sys.exit(0)

		while (True):
			RESULT = self.CD.ShowDialog("Files that differ",diffDict)
			if not RESULT or RESULT == "":
				os.system("clear")
				sys.exit(0)
			else:
				os.system("vimdiff %s/%s %s/%s" % (self.dir1,RESULT,self.dir2,RESULT))
				#s = raw_input('"HIT ENTER TO CONTINUE')

		sys.exit(0)


	def generateDiffDict(self, dcmp):

		diffDict = {}

		print dcmp.left
		for name in dcmp.diff_files:
			filenameLeft = "%s/%s" % (dcmp.left,name)
			filenameLeft = filenameLeft.replace(self.dir1,"").replace(self.dir2,"")
			if not self.does_string_contain(filenameLeft, self.stopwords):
				print "diff_file %s" % (filenameLeft)
				diffDict[filenameLeft] = "----both----"
			else:
				print "checked %s" % (filenameLeft)


		for name in list(set(dcmp.left_list) - set(dcmp.right_list)):
			filename = "%s/%s" % (dcmp.left,name)
			filename = filename.replace(self.dir1,"").replace(self.dir2,"")
			if not self.does_string_contain(filename, self.stopwords):
				diffDict[filename] = "dir1--------"
				print "LEFT - %s" % (filename)

		for name in list(set(dcmp.right_list) - set(dcmp.left_list)):
			filename = "%s/%s" % (dcmp.right,name)
			filename = filename.replace(self.dir1,"").replace(self.dir2,"")
			if not self.does_string_contain(filename, self.stopwords):
				diffDict[filename] = "--------dir2"
				print "RIGHT - %s" % (filename)

		for sub_dcmp in dcmp.subdirs.values():
			if (
				not self.does_string_contain(sub_dcmp.left, self.stopwords)
				and not self.does_string_contain(sub_dcmp.right, self.stopwords)
				#noone likes symlink infinite loops
				and not os.path.islink(sub_dcmp.left)
				and not os.path.islink(sub_dcmp.right)
			):
				diffDict.update(self.generateDiffDict(sub_dcmp))

		return diffDict


	def does_string_contain(self, text, stopwords):
		for word in stopwords:
			if word in text:
				return True
		return False




def main():
	if len(sys.argv) > 2:
		GDM = GnarleyDiffMerge(sys.argv[1], sys.argv[2])
		GDM.run()
	else:
		print "usage:"
		print "     gnarleyDiffMerge <dir1> <dir2>"
	sys.exit(0)

if __name__ == "__main__":
	main()



