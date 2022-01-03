#Author: Grimy88
﻿import os
import random
from datetime import datetime

def changeRegistryValue(location, name, value, type):
    defaultLoc = "HKEY_LOCAL_MACHINE\\SOFTWARE\\"
    randomNo = random.randint(0,9999)
    tmpRegFile = str(randomNo)+".reg"
    f = open(tmpRegFile, "w")
    
    try:
        f.write("REGEDIT4\n\n")
        f.write("[" +defaultLoc + location+ "\\]\n")
        if(type == "dword"):
            f.write("\"" + name + "\"=" + type+":"+value + "\n")
        else:
            f.write("\"" + name + "\"=\"" + value + "\"\n")
        f.flush()
        f.close()
        os.system("regedit" + ' /s ' + tmpRegFile)
        os.remove(tmpRegFile)
        
    except Exception:
        os.remove(tmpRegFile)
        dt = datetime.now()
        currTime = dt.strftime('%Y/%m/%d %H:%M:%S')
        f = open("chRegLog.txt", "a")
        f.write("Script was ran at " + currTime + ".\n Something went wrong while generating the registry file or while executing. Please check the parameter values passed to this function.")
        f.close()
        
    
#Code Examples
changeRegistryValue("My\\Path\\To\\Reg", "TestDword", "0001AA8F", "dword")
changeRegistryValue("My\\Path\\To\\Reg", "Test", "new test value", "string")