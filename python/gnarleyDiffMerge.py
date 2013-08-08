#!/usr/bin/env python
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
				#sys.exit(0)
				continue
		#raw_input("Press ENTER to continue")

		#SETC=""
		#SETC=" \"---\" \"---\" "
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
		self.CD = ConsoleDialog()
		self.dir1 = dir1
		self.dir2 = dir2

	def run(self):
		self.generateDiffFileList()
		while (True):
			RESULT = self.CD.ShowDialog("Files that differ",self.diffDict)
			if not RESULT or RESULT == "":
				os.system("clear")
				sys.exit(0)
			else:
				os.system("vimdiff %s/%s %s/%s" % (self.dir1,RESULT,self.dir2,RESULT))
				#s = raw_input('"HIT ENTER TO CONTINUE')

	def generateDiffFileList(self):
		#commandResult = self.doSystemCommand(diffCommand)
		#print commandResult 
		print "Scanning for files..."

		dir1Files = self.pullAllFiles(self.dir1)
		dir2Files = self.pullAllFiles(self.dir2)

		self.diffDict = self.compareFilesLists(dir1Files, dir2Files)

	def compareFilesLists(self, dir1Files, dir2Files):
		totalCount = len(dir1Files) + len(dir2Files)
		print "Found %s files to scan.  Scanning now..." % (totalCount)

		newDict = {}
		for dir1 in dir1Files:
			if dir1 in dir2Files:
				newDict[dir1] = "----both----"
			else:
				newDict[dir1] = "dir1--------"

		for dir2 in dir2Files:
			if dir2 not in dir1Files:
				newDict[dir2] = "--------dir2"

		print "Checking for differences..."

		diffDict = {}
		for fileName in newDict:
			if newDict[fileName] == "----both----":
				diffCommand = "diff -q %s/%s %s/%s" % (self.dir1, fileName, self.dir2, fileName)
				stdout, stderr = self.doSystemCommand(diffCommand)
				if stdout:
					diffDict[fileName] = newDict[fileName]
					print "Found %s changed files" %(len(diffDict))
			else:
				diffDict[fileName] = newDict[fileName]
				print "Found %s changed files" %(len(diffDict))

		return diffDict


	def does_string_contain(self, text, stopwords):
		for word in stopwords:
			if word in text:
				return True
		return False

	def pullAllFiles(self, dir):
		allFilesList = []
		stopwords=['.svn','aws-sdk','.png','.jpg','.gif']

		for root, subFolders, files in os.walk(dir.encode("ascii")):
			for file in files:
				truncatedRoot = root.replace(dir + "/","")
				fileName = os.path.join(truncatedRoot,file)

				if not self.does_string_contain(fileName, stopwords):
					allFilesList.append(fileName)


		return allFilesList

	def doSystemCommand(self, cmd):
		p = Popen(cmd, shell=True, stdout=PIPE, stderr=PIPE)
		#stdout, stderr = p.communicate()
		#return stdout
		return p.communicate()





###### START STUFF  ###############

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






############ DEFINE FUNCTONS HERE #############
#
#def gnarleyShowPaths():   
#	#shows environment paths currently set
#	for path in  os.environ["PATH"].split(":"):
#		print path
#
#def printSystemCommand(cmd):
#	stdout, stderr = doSystemCommand(cmd)
#	result = stdout.strip(' \t\n\r')
#	if result != "":
#		print result




