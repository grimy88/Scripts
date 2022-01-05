import os
import sys

def setDate(date="", time=""):	

	#In this part you can manually set the date and time in case no parameters are sent
	tmpDate = "12.02.2016."
	tmpTime = "13:00"
		
	if (date != ""):
		os.system("date " + date)
		if (time != ""):
			os.system("time " + time)
	elif (date == ""):
		os.system("date " + tmpDate)
		if (time == ""):
			os.system("time " + tmpTime)
	else:
		print("Please check the parameters sent and try again. Parameters sent are: %s" % date, time)


		
#Example
#setDate()