from xml.dom import minidom
import logging

#    Logger setup
logger = logging.getLogger('parseXML')
#    Location for log file
hdlr = logging.FileHandler('parseXML.log')
formatter = logging.Formatter('%(asctime)s %(levelname)s %(message)s')
hdlr.setFormatter(formatter)
logger.addHandler(hdlr)

logger.setLevel(logging.DEBUG)

#   Method returns true and false depending on the result of seached element and its value, parameters used:
#    1) path is the location where the zip files will be located
#    2) tag is the tag which will be used to search for the node in xml type document
#   3) value is the searched value which needs to be checked
#    4) attribute is used to search for the attribute whose value will be used to verify (check)
#    5) searchName is used to search for the attribute which will help define the right element with specific tag
#    6) searchValue is used to check the value for the searched attribute to verify the correct element is used
#   Mandatory parameters are file (location and name.extension), tag which will be used to search for element,
#    value which will be used to check if the value is what we expect for the specified element,
#    attribute, searchName and searchValue will have default values as empty string in case their values are not sent as parameters

def parseXML(path, tag, value, attribute="", searchName="", searchValue=""):
    #Parsing the file and searching for the initial element
    xmldoc = minidom.parse(path)
    element = xmldoc.getElementsByTagName(tag)
            
    # 1) Search for element and check node value
    if (searchName == "" and searchValue == "" and attribute == ""):
        elementValue = element[0].childNodes[0].nodeValue
        if value == elementValue:
            logging.info("Successfully found element with tag: " + tag + " which has value: " + elementValue + " in file on location : " + path + ".")
            return True
        else:
            logging.info("A problem has been found, the element value is " + elementValue + " the searched value is " + value + " in file on location: " + path + ".")
            return False

    # 2) Search for element and check the attribute value
    if (searchName == "" and searchValue == "" and attribute != ""):
        elementValue = element[0].getAttribute(attribute)
        if value == elementValue:
            logging.info("Successfully found element with tag: " + tag + " which has attribute: " + attribute + " with value: " + elementValue + " in file on location: " + path + ".")
            return True
        else :
            logging.info("A problem has been found, the attribute value is " + elementValue + " the searched value is " + value + " for element with tag: " + tag + " in file location: " + path + ".")
            return False
    
    # 3) Search for elements with specific tag
    #    Go through each of them and check the attributes and their values
    if (searchName != "" and searchValue != "" and attribute != ""):
        for e in element:
            valueCheck = e.attributes[searchName].value
            if searchValue == valueCheck:
                attributeValue = e.attributes[attribute].value
                if attributeValue == value:
                    logging.info("Successfully found element with tag: " + tag + " with attribute: " + attribute + " which has value: " + attributeValue + " in file on location: " + path + ".")
                    return True
        logging.info("A problem has been found, the searched element with tag: " + tag + " with the searched attribute: " + attribute + " and attribute value: " + value + " could not be found in file on location: " + path + ".")
        return False﻿

#    Example call

path = "D:\\TestXML\\"
result = parseXML(path,"SameTag","somevalue1","value","name","somevalue1")﻿
