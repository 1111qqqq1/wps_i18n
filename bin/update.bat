@echo off
@REM update.bat�Ĺ�������Ϊ��
@REM	1. ��ȡ���ϲ����̵ķ�����Դ (kcomctl kxshare et wps wpp)
@REM	2. ��ȡ���ϲ�UI XML�ķ�����Դ(update_ui.bat)
@REM	3. ��ȡ���ϲ��ں˷���
@REM	4. ��ȡoffice\kde\kde_coreapi�ķ���
@REM	5. ��ȡshell2\auth�ķ���
@REM	6. ��ȡ���ϲ�tips����(ע:tips����qtTrId()����������id)

@REM ====================================================================================================
@REM ��������Ч��

if "%g_target_lang%" == "" (
	set g_errstr=does not give language
	exit /b 1
)

for %%i in (%g_et_uis%) do (
	if not exist %g_uis_path%\%%i (
		set g_errstr=%cd%\%g_uis_path%\%%i does not exist
		exit /b 1
	)
)
for %%i in (%g_wps_uis%) do (
	if not exist %g_uis_path%\%%i (
		set g_errstr=%cd%\%g_uis_path%\%%i does not exist
		exit /b 1
	)
)
for %%i in (%g_wpp_uis%) do (
	if not exist %g_uis_path%\%%i (
		set g_errstr=%cd%\%g_uis_path%\%%i does not exist
		exit /b 1
	)
)
for %%i in (%g_projs%) do (
	if not exist %g_projs_path%\%%i (
		set g_errstr=%cd%\%g_projs_path%\%%i does not exist
		exit /b 1
	)
)
for %%i in (%g_tips%) do (
	if not exist %g_tips_path%\%%itips.h (
		set g_errstr=%cd%\%g_tips_path%\%%itips.h does not exist
		exit /b 1
	)
)

@REM TODO need to create

if not exist %g_ts_path% (
	set g_errstr=%cd%\%g_ts_path% does not exist
	exit /b 1
)


@REM ====================================================
@REM	1. ��ȡ���ϲ����̵ķ�����Դ (kcomctl kxshare et wps wpp and so on)
set locationType=none
if "%g_locationType%"=="1" (
    set locationType=relative
)
if "%g_locationType%"=="2" (
    set locationType=absolute
)
for %%i in (%g_projs%) do (
	for /f "delims=" %%j in ("%%i") do (
		if "%g_target_lang%"=="" (
			if "" == "%g_defaultcodec%" (
				%g_tools_bin%\lupdate.exe -silent -locations %locationType% %g_projs_path%\%%i -ts %g_ts_path%\%%~nj.ts
			) else (
				%g_tools_bin%\lupdate.exe -silent -locations %locationType% -codecfortr %g_defaultcodec% %g_projs_path%\%%i -ts %g_ts_path%\%%~nj.ts
			)
		) else (
			if "" == "%g_defaultcodec%" (
				%g_tools_bin%\lupdate.exe -silent -locations %locationType% -target-language %g_target_lang% %g_projs_path%\%%i -ts %g_ts_path%\%%~nj.ts
			) else (
				%g_tools_bin%\lupdate.exe -silent -locations %locationType% -codecfortr %g_defaultcodec% -target-language %g_target_lang% %g_projs_path%\%%i -ts %g_ts_path%\%%~nj.ts
			)
		)
	)
)

@REM ====================================================
@REM	2. ��ȡ���ϲ�XML�ķ�����Դ
call update_ui.bat et "%g_et_uis%"
call update_ui.bat wps "%g_wps_uis%"
call update_ui.bat wpp "%g_wpp_uis%"


@REM ====================================================
@REM	3. ��ȡ���ϲ��ں˷���

echo chenjiexin: ��ʱ�������뾫ͨBAT����־��ʿ�Ż�֮
set g_core_projs=et wps wpp

for %%i in (%g_core_projs%) do (
	%g_tools_bin%\lupdate.exe -silent -locations %locationType% -codecfortr %g_defaultcodec% -target-language %g_target_lang% -recursive %g_core_projs_path%\%%i -ts %g_ts_path%\%%icore.ts
)

set g_core_projs=kso
for %%i in (%g_core_projs%) do (
	%g_tools_bin%\lupdate.exe -silent -locations %locationType% -codecfortr %g_defaultcodec% -target-language %g_target_lang% -recursive %g_core_projs_path%\%%i -ts %g_ts_path%\%%i.ts
)

@REM ====================================================
@REM	4. ��ȡoffice\kde\kde_coreapi�ķ���

%g_tools_bin%\lupdate.exe -silent -locations %locationType% -codecfortr %g_defaultcodec% -target-language %g_target_lang% -recursive %g_kde_projs_path% -ts %g_ts_path%\%g_kde_ts%


@REM ====================================================
@REM	5. ��ȡshell2\auth�ķ���

%g_tools_bin%\lupdate.exe -silent -locations %locationType% -codecfortr %g_defaultcodec% -target-language %g_target_lang% -recursive %g_auth_projs_path% -ts %g_ts_path%\%g_auth_ts%
@REM ====================================================
@REM	6. ��ȡ���ϲ�shell2\include\tips�ķ���

for %%i in (%g_tips%) do (
	%g_tools_bin%\lupdate.exe -silent -locations %locationType% -codecfortr %g_defaultcodec% -target-language %g_target_lang% -recursive %g_tips_path%\%%itips.h -ts %g_ts_path%\%%itips.ts
)

@REM ====================================================
@REM	7. ��ȡshell2\plugins\kwpslive\qing�ķ���

%g_tools_bin%\lupdate.exe -silent -locations %locationType% -codecfortr %g_defaultcodec% -target-language %g_target_lang% -recursive %q_qing_projs_path% -ts %g_ts_path%\%g_qing_ts%

@REM ====================================================

@exit /b 0