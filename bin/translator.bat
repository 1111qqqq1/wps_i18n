@echo off

set g_coding=../Coding
if exist %g_coding% goto next
set g_coding=../../Coding
if exist %g_coding% goto next
set g_coding=../../../Coding
if exist %g_coding% goto next
set g_coding=../../../../Coding
if exist %g_coding% goto next
set g_coding=../../../../../Coding
if exist %g_coding% goto next
set g_coding=../../../../../../Coding
if exist %g_coding% goto next
set g_errstr=cann't find coding directory 
goto ERREXIT

:next
call %g_coding%\shell2\mui\bin\config_file.bat zh_CN
start %g_tools_bin%\linguist.exe 
exit /b 0

:ERREXIT
echo. 
if "%g_errstr%"=="" (
	echo ����qm�ļ��ɹ�!
) else (
	echo ����qm�ļ����ִ�����ʾ���£�
	echo %g_errstr%
)

pause