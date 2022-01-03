# Python and batch scripts


Protractor script:
Protractor script is used to generate a new project for Protractor.
User will be given options to generate configuration for protractor project.
Read release notes for protractor project script.

Delete old files:
Batch script to delete files older then given number of days.

Helper functions in python:
helper functions to clean folder and to create a directory (folder) if it does not exist on a specific location.

Parse XML in python:
This method is used to search for element inside xml file and its value, depending on the type of value we are doing different searches. The searched value type can be an elements attribute value and the nodes value. Also we have a couple more parameters in case we have multiple instances of the same tag in the xml.
We have a couple of cases for which this code is for:

    We search for the tag and that nodes value.
    We search for tag and an attribute inside the tag and check the value of the attribute.
    We search for the tag which has multiple instances with same name so we use one attribute and its value to go through all of the instances to find the one we need, after which we look for the actual attribute we need and check its value.

In the xml example you can find all of the noted cases. For the first two cases you can take any tag you want, for the last case the tag with name "SameTag" or "Function" can be used. 
