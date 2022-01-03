@ECHO off
TITLE Create protractor project
COLOR 0f
ECHO [INFO] Please make sure Node.js is installed on your computer and npm also works.
ECHO [INFO] You can check it by typing "node -v" or "npm -v"



:HEADER
	ECHO Name your project:
	SET /P project_name= 
	mkdir %project_name%
	cd %project_name%
	cls
	ECHO Write the description of your project:
	SET /P project_description=
	cls
	ECHO Would you like to use typeScript?
	ECHO 1:Yes
	ECHO 2:No
	SET /P type_script=
	cls
	ECHO Do you want to use Jasmine?
	ECHO 1: Yes
	ECHO 2: No
	SET /P jasmine=
	cls
	ECHO Do you want to use cucumber with chai for assertions?
	ECHO 1: Yes 
	ECHO 2: No
	SET /P cucumber_chai=
	cls
	ECHO What is the name of your main file?
	ECHO [Please write file name with .js extension]
	ECHO [If you are not sure or nothing is inserted, index.js will be used]
	SET /P main_file=
	IF "%main_file%"=="" SET main_file=index.js
	cls
	ECHO Who is the author of this project?
	SET /P author=
	cls
	ECHO Do you want cucumber html reporter?
	ECHO 1: Yes
	ECHO 2: No
	SET /P cucumber_reporter=
	cls
	ECHO Do you want to generate timeout file for non angular applications?
	ECHO 1: Yes
	ECHO 2: No
	SET /P timeout=
	cls
	IF %timeout%==1 (
		ECHO How many seconds do you want the timeout to be?
		SET /P timeoutSeconds=
		cls
	)
	ECHO Do you want to set screenshot capture for failed tests?
	ECHO 1: Yes
	ECHO 2: No
	SET /P screenshot=
	cls
	CALL :PACKAGE_FILE



:PACKAGE_FILE
	ECHO { > package.json
	ECHO "name" : "%project_name%", >> package.json
	ECHO "version" : "1.0.0", >> package.json
	ECHO "description" : "%project_description%", >> package.json
	ECHO "main" : "%main_file%", >> package.json
	ECHO "scripts" : { >> package.json
	IF %cucumber_chai%==1 ECHO "test" : "JSFiles/cucumberconfiguration.js", >> package.json
	IF %type_script%==1 ECHO "pretest" : "tsc", >> package.json
	ECHO "protractor": "./node_modules/protractor/built/cli.js", >> package.json
	ECHO "webdriver-update": "./node_modules/.bin/webdriver-manager update" >> package.json
	ECHO }, >> package.json
	ECHO "author": "%author%", >> package.json
	ECHO "license": "ISC", >> package.json
	ECHO "dependencies": { >> package.json
	ECHO "protractor": "^5.4.2", >> package.json
	IF %type_script%==1 ECHO "typescript": "~3.3.1", >> package.json
	IF %jasmine%==1 ECHO "jasmine": "~3.3.1", >> package.json
	IF %type_script%==1 (
		IF %jasmine%==1 (
			ECHO "@types/jasmine": "^3.3.8", >> package.json
			ECHO "@types/jasminewd2": "^2.0.6", >> package.json
		)
	)
	IF %type_script%==1 ECHO "ts-node": "^8.0.2", >> package.json
	IF %type_script%==1 ECHO "@types/node": "^10.12.21", >> package.json
	ECHO "protractor-cucumber-framework": "^6.1.1", >> package.json
	IF %cucumber_chai%==1 ECHO "cucumber": "^5.1.0", >> package.json
	IF (%type_script%==1) IF (%cucumber_chai%==1) ECHO "@types/cucumber": "^4.0.4", >> package.json
	IF %cucumber_chai%==1 (
		ECHO "chai": "^4.2.0", >> package.json
		ECHO "chai-as-promised": "^7.1.1", >> package.json
	)
	IF %cucumber_reporter%==1 ECHO "cucumber-html-reporter": "^4.0.4" >> package.json
	ECHO } >> package.json
	ECHO } >> package.json
	CALL :CONFIG
	


:CONFIG
	ECHO import { > configuration.ts 
	ECHO Config, browser >> configuration.ts
	ECHO } from 'protractor'; >> configuration.ts
	IF %cucumber_reporter%==1 (
		CALL :IMPORT_CUCUMBER_REPORTER
	) ELSE (
		CALL :ON_PREPARE_CONFIG
	)
	
	

:GENERATE_TIMEOUT_FILE
	mkdir stepsDefinitions
	cd stepsDefinitions
	ECHO var {setDefaultTimeout} = require('cucumber'); > timeout.ts
	ECHO setDefaultTimeout(%timeoutSeconds% * 1000); >> timeout.ts
	cd ..
	IF %screenshot%==1 CALL :SET_SCREENSHOOTING



:SET_SCREENSHOOTING
	IF NOT EXIST stepsDefinitions mkdir stepsDefinitions
	cd stepsDefinitions
	ECHO import {After, Before, Status} from "cucumber"; > hooks.ts
	ECHO import {browser} from "protractor"; >> hooks.ts
	ECHO. >> hooks.ts
	ECHO After(async function(scenario) { >> hooks.ts
	ECHO if (scenario.result.status === Status.FAILED) { >> hooks.ts
	ECHO const screenshot= await browser.takeScreenshot(); >> hooks.ts
	ECHO this.attach(screenshot,"image/png"); >> hooks.ts
	ECHO } >> hooks.ts
	ECHO }); >> hooks.ts
	CALL :NPM_INSTALL

	
	
:ON_PREPARE_CONFIG
	ECHO export let config: Config = { >> configuration.ts
	ECHO //seleniumAddress: 'http://localhost:4444/wd/hub', >> configuration.ts
	ECHO onPrepare: () =^> { >> configuration.ts
	ECHO browser.manage().window().maximize(); >> configuration.ts
	ECHO }, >> configuration.ts
	ECHO directConnect: true, >> configuration.ts
	CALL :FINISH_CONFIGURATION_WITHOUT_REPORTER



:IMPORT_CUCUMBER_REPORTER
	ECHO import * as reporter from 'cucumber-html-reporter'; >> configuration.ts
	ECHO. >> configuration.ts
	ECHO export let config: Config = { >> configuration.ts
	ECHO //seleniumAddress: 'http://localhost:4444/wd/hub', >> configuration.ts
	ECHO onPrepare: () =^> { >> configuration.ts
	ECHO browser.manage().window().maximize(); >> configuration.ts
	ECHO }, >> configuration.ts	
	CALL :ON_COMPLETE_REPORTER
	
	

:ON_COMPLETE_REPORTER
	ECHO onComplete: () =^> { >> configuration.ts
	ECHO var options = { >> configuration.ts
	ECHO theme: 'bootstrap', >> configuration.ts
	ECHO jsonFile: './cucumberreport.json', >> configuration.ts
	ECHO output: './cucumber_report.html', >> configuration.ts
	ECHO reportSuiteAsScenarios: true, >> configuration.ts
	ECHO launchReport: true, >> configuration.ts
	ECHO metadata: { >> configuration.ts
	ECHO "App Version":"0.3.2", >> configuration.ts
	ECHO "Test Environment": "STAGING", >> configuration.ts
	ECHO "Browser": "Chrome  54.0.2840.98", >> configuration.ts
	ECHO "Platform": "Windows 10", >> configuration.ts
	ECHO "Parallel": "Scenarios", >> configuration.ts
	ECHO "Executed": "Remote" >> configuration.ts
	ECHO } >> configuration.ts
	ECHO }; >> configuration.ts
	ECHO. >> configuration.ts
	ECHO reporter.generate(options); >> configuration.ts
	ECHO }, >> configuration.ts
	ECHO. >> configuration.ts
	ECHO directConnect: true, >> configuration.ts
	CALL :FINISH_CUCUMBER_REPORTER


	
:FINISH_CUCUMBER_REPORTER
	ECHO. >> configuration.ts
	ECHO framework: 'custom', >> configuration.ts
	ECHO frameworkPath: require.resolve('protractor-cucumber-framework'), >> configuration.ts
	ECHO. >> configuration.ts
	ECHO specs: [ >> configuration.ts
	ECHO '../features/testFeature.feature' >> configuration.ts
	ECHO ], >> configuration.ts
	ECHO. >> configuration.ts
	ECHO cucumberOpts: { >> configuration.ts
	ECHO format: 'json:./cucumberreport.json', >> configuration.ts
	ECHO require: [ >> configuration.ts
	ECHO './stepsDefinitions/steps.js', >> configuration.ts
	ECHO './stepsDefinitions/timeout.js', >> configuration.ts
	ECHO './stepsDefinitions/hooks.js' >> configuration.ts
	ECHO ] >> configuration.ts
	ECHO } >> configuration.ts
	ECHO } >> configuration.ts
	IF %timeout%==1	CALL :GENERATE_TIMEOUT_FILE
	IF %screenshot%==1 CALL :SET_SCREENSHOOTING
	CALL :NPM_INSTALL



:FINISH_CONFIGURATION_WITHOUT_REPORTER
	ECHO specs: ['testSpec.js'] >> configuration.ts
	ECHO } >> configuration.ts
	IF %timeout%==1	CALL :GENERATE_TIMEOUT_FILE
	IF %screenshot%==1 CALL :SET_SCREENSHOOTING
	CALL :NPM_INSTALL
	


:NPM_INSTALL
	IF %type_script%==1 call npm install -g typescript
	IF %type_script%==1 call tsc --init
	call npm install 
	call webdriver-manager update
	cls
	GOTO END


	
:END
	ECHO Your project name is: %project_name%
	IF %type_script%==1 ECHO TypeScript is enabled
	IF %jasmine%==1 ECHO Jasmine is enabled
	IF %cucumber_chai%==1 ECHO Cucumber with Chai for assertions is enabled 
	ECHO Name of your main file is %main_file%
	IF %cucumber_reporter%==1 ECHO Cucumber reporter is enabled
	IF %timeout%==1 ECHO Timeout is set to %timeoutSeconds%
	IF %screenshot%==1 ECHO Taking screenshots for failed test is enabled 
	ECHO Thank you for using Grimy88 scripts, have fun coding in your newly created project.
	pause
	EXIT