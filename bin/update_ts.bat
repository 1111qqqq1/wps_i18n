@echo off

@REM error string
set g_errstr=

:next
call config_file.bat %1 %2
if not "%g_errstr%"=="" goto ERREXIT

call update.bat

:ERREXIT
echo. 
if "%g_errstr%"=="" (
	echo %1: ��ȡ���ϲ������ļ��ɹ�! 
) else (
	echo %1: ��ȡ���ϲ������ļ����ִ�����ʾ���£�
	echo %g_errstr% 
	pause
	exit 1
)
