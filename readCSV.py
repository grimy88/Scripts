#Author: Grimy88
﻿def getSelectedValue(number):
    f = open("yourFileName.csv", "r")
    myList = []
    myString = ""
    endingString = ""
    for line in f:    
        myString = line
    f.close()
    myList = myString.split(",")
    f1 = open("resultFileName", "w")
    f1.write(myList[number])
    f1.close()
    myList.remove(myList[number])
    endingString = endingString.join(str(e+", ") for e in myList)
    f = open("yourFileName.csv", "w")
    f.write(endingString)
    f.close()
    

#Code Example
getSelectedValue(4)