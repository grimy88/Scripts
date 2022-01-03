# @Author: Grimy88

import logging
import os﻿
﻿
﻿#    Method to delete all files on the specified folder location        
def cleanupFolder(path):
    logger.info("Cleaning up folder for next test case.")
    for filename in os.listdir(path):
        filepath = os.path.join(path, filename)
        logger.info("File: " + filepath + " is deleted.")
        os.remove(filepath)
   
#    Method to create directory in case it does not exist     
def checkForDirAndCreate(path, dirName):
    fullpath = path + dirName
    if not os.path.isdir(fullpath):
        os.mkdir(fullpath)   

#   Example call
path = "D:\\TestDir"
dirName = "testDir"﻿﻿
cleanupFolder(path)
checkForDirAndCreate(path, dirName)﻿﻿