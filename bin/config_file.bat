@echo off
@REM �����ļ������нű�������ʱ��Ҫ�����ļ��ڵ���Ϣ��
@REM �������: language,[qm output path]

@REM TODO ���ڴ��������鷳
@REM input param
set g_target_lang=%1

if not "%2" == "" set g_coding=%2
if "%g_coding%" == "" (
	set g_coding=..\..\..\
)

set "g_coding=%g_coding:"=%"

if not "%3" == "" set g_qm_path=%3
if "%g_qm_path%" == "" (
	set g_qm_path=..\%g_target_lang%
)

@REM error Description
set g_errstr=

@REM =======================================ȫ�ֲ�������==================================================
set g_tools_bin=%~dp0
set g_mui_path=%g_coding%\shell2\mui

@REM kui[p] files
set g_uis_path=%g_coding%\shell2\resource\res
set g_ui2ts_version=2

@REM projects ��Ҫ����ts�ļ��Ĺ���, ts�ļ���Ϊ������.ts
set g_projs_path=%g_coding%\shell2
set g_projs=kcomctl kxshare kole et wpp wps plugins\wpstablestyle plugins\ettablestyle plugins\khomepage plugins\ktreasurebox plugins\wpp2doc plugins\wpponlinetemplate plugins\officespace plugins\multiclipboard plugins\kscreengrab ..\support\ksomisc plugins\protecteyes plugins\kwpsassist plugins\wppencoder plugins\wpppresentationtool plugins\wpsspeaker plugins\launcher plugins\kfeedback plugins\shareplay
set g_core_projs_path=%g_coding%\include\kso\l10n
set g_kde_projs_path=%g_coding%\office\kde\kde_coreapi
set g_auth_projs_path=%g_coding%\shell2\auth
set q_qing_projs_path=%g_coding%\shell2\plugins\kwpslive\qing

@REM tips
set g_tips_path=%g_coding%\shell2\include\tips
set g_tips=et wps wpp kso

@REM ts files
@REM ��Ҫ��ÿ�����̵�ts�ļ�����qm�ļ��������Ѿ��Ƶ�ÿ�����Թ��̵�cmakelist�У������¼�ts��Ҫ�޸�
@REM Coding/shell2/mui/CMakeLists.txt��ά����ts�б�ͬʱ������Ŀ¼��CMakeLists.txt������ʹ��
@REM cmake��wps_custom_compile����lrelease�����ɣ������ڹ���ʱ����qm�����ļ�
set g_ts_path=..\%g_target_lang%\ts
set g_et_ts=et.ts etresource.ts ettablestyle.ts etcore.ts protecteyes.ts
set g_wps_ts=wps.ts wpsresource.ts wpstablestyle.ts wpscore.ts protecteyes.ts
set g_wpp_ts=wpp.ts wppresource.ts wpp2doc.ts wpponlinetemplate.ts wppcore.ts
set g_kso_ts=qt.ts kxshare.ts kcomctl.ts kole.ts khomepage.ts ktreasurebox.ts officespace.ts multiclipboard.ts kso.ts kscreengrab.ts shareplay.ts kwpsassist.ts wppencoder.ts wpppresentationtool.ts wpsspeaker.ts 
set g_ksomisc_ts=ksomisc.ts
set g_launcher_ts=launcher.ts
set g_kde_ts=kde.ts
set g_auth_ts=auth.ts
set g_qing_ts=qing.ts
set g_et_tips_ts=ettips.ts
set g_wps_tips_ts=wpstips.ts
set g_wpp_tips_ts=wpptips.ts
set g_kso_tips_ts=ksotips.ts

@REM qm files
set g_et_qm_name=et.qm
set g_wps_qm_name=wps.qm
set g_wpp_qm_name=wpp.qm
set g_kso_qm_name=kso.qm
set g_ksomisc_qm_name=ksomisc.qm
set g_launcher_qm_name=launcher.qm
set g_qing_qm_name=qing.qm
set g_et_tips_qm_name=ettips.qm
set g_wps_tips_qm_name=wpstips.qm
set g_wpp_tips_qm_name=wpptips.qm
set g_kso_tips_qm_name=ksotips.qm

@REM option. defaultcodec����Ϊ��.
@REM location type: 0: no location, 1:relative location, 2:absolute location
set g_obsolete=false
set g_defaultcodec=UTF-8
set g_locationType=0

