@rem ��echo�ر�Ϊ���۶���
@echo off


rem ���ñ������������ļ�
set domainFile=%SystemRoot%\system32\drivers\etc\hosts
rem ����д���ݿ�����
set db_write_domain=sangdatawrite.com
set db_write_domain_ip=localhost
set db_write_domain_config=%db_write_domain_ip% %db_write_domain%
rem ���ö����ݿ�����
set db_read_domain=sangdataread.com
set db_read_domain_ip=localhost
set db_read_domain_config=%db_read_domain_ip% %db_read_domain%
rem ���û����������
set cache_domain=sangcache.com
set cache_domain_ip=localhost
set cache_domain_config=%cache_domain_ip% %cache_domain%
rem �����ļ���������
set file_domain=www.sangfileapp.com
set file_domain_ip=localhost
set file_domain_config=%file_domain_ip% %file_domain%

rem ��ʾ������Ϣ
echo     domainFile                 =   %domainFile%
echo     db_write_domain_config    =   %db_write_domain_config%
echo     db_read_domain_config     =   %db_read_domain_config%
echo     cache_domain_config        =   %cache_domain_config%
echo     file_domain_config   =   %file_domain_config%

rem ȷ���������������Ƿ����
if exist %domainFile% goto fileExit

:fileNotExit
echo �������������ļ�������
goto error

:fileExit

rem �鿴�����������������Ƿ�����Ӧ��Ϣ�����û�������������Ϣ
:set_localhost
type %domainFile% | find /i "%db_write_domain_config%"&&goto set_write
echo 127.0.0.1 localhost >> %domainFile%
:set_write
type %domainFile% | find /i "%db_write_domain_config%"&&goto set_read
echo %db_write_domain_config% >> %domainFile%
:set_read
type %domainFile% | find /i "%db_read_domain_config%"&&goto set_cache
echo %db_read_domain_config% >> %domainFile%
:set_cache
type %domainFile% | find /i "%cache_domain_config%"&&goto set_file
echo %cache_domain_config% >> %domainFile%
:set_file
type %domainFile% | find /i "%file_domain_config%"&&goto end_set
echo %file_domain_config% >> %domainFile%
:end_set
type %domainFile%

set configPath=%cd%

rem ����redis-server
cd %configPath%\redis*
rem ��ֹ��ؽ���
taskkill /im redis* /f
redis-server.exe redis.conf
if ERRORLEVEL 9009 goto :error
echo redis��������������ɹ�

rem ����MySQL����
net start mysql

if ERRORLEVEL 128 goto success
if ERRORLEVEL 0 goto success

:error
echo ����ʧ��
goto end
:success
echo �����ɹ�
:end
pause
