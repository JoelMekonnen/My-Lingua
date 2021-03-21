import json
#lets create the basic class that accepts dictionary and returns a json file
class Converter():
    myDict = list()
    outputName = ''
    fileHandle = 0
    def __init__(self, DictVal, name):
        self.myDict = DictVal
        self.outputName = name
        self.fileHandle = open(self.outputName, mode='w+')
    def convert(self):
        json.dump(self.myDict, self.fileHandle,sort_keys=True, indent=4)
        self.fileHandle.close()
    def showVal(self):
        fileHandle = open(self.outputName, mode='r')
        print(fileHandle.name)
        for line in fileHandle:
            print(line)
        fileHandle.close()


