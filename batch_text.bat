@echo off
REM setlocal enabledelayedexpansion

set _color=0&set _file=0
:go_back
if not exist text%_file%.txt type nul>text%_file%.txt
cls&title ******* SIMPLE BATCH TEXT FILE MAKER *******
echo 1. Save and exit
echo 2. Change text color
echo 3. Save and make a new file
echo 4. Clear text
echo 5. Edit line
echo:
echo            text%_file%.txt
echo =========================================
set _line=0
for /f "delims=" %%g in (text%_file%.txt) do (
	call :go_line "%%g"
)
echo =========================================
echo:
set /p "_txt="
if "%_txt%"=="1" (
	goto :go_out
)else if "%_txt%"=="2" (
	call :go_color
)else if "%_txt%"=="3" (
	set /a _file+=1
)else if "%_txt%"=="4" (
	type nul>text%_file%.txt
)else if "%_txt%"=="5" (
	call :go_edit
	
)else ( for /f "delims=" %%g in ("%_txt%") do echo %%~g) >>text%_file%.txt



goto :go_back
:go_out
exit

:go_line
	set /a _line+=1
	echo %_line% %~1
exit /b

:go_color
	set /a _color+=1
	if %_color% equ 10 set _color=1
	color %_color%
exit /b

:go_edit
	set /p "_line=Enter the # of the line: "
	set /p "_txt=Enter new text for the line: "
	
	type nul>temp.txt
	set /a _num=%_line%-1
	set /a _num2=%_line%
	
	setlocal enabledelayedexpansion
	set _count=0
	for /f "delims=" %%g in (text%_file%.txt) do (
		echo %%g>>temp.txt
		set /a _count+=1
		echo !_count!
		if !_count! equ !_num! goto :go_next
	)
	setlocal disabledeleyedexpansion
	
	:go_next
	echo !_txt!>>temp.txt
	
	
	for /f "skip=%_num2% delims=" %%g in (text%_file%.txt) do (
		echo %%g>>temp.txt
	)
	
	del text%_file%.txt & ren temp.txt text%_file%.txt

exit /b