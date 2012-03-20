@rem 将echo关闭为美观而已
@echo off


rem 设置本地域名解析文件
set domainFile=%SystemRoot%\system32\drivers\etc\hosts
rem 设置写数据库域名
set db_write_domain=sangdatawrite.com
set db_write_domain_ip=localhost
set db_write_domain_config=%db_write_domain_ip% %db_write_domain%
rem 设置读数据库域名
set db_read_domain=sangdataread.com
set db_read_domain_ip=localhost
set db_read_domain_config=%db_read_domain_ip% %db_read_domain%
rem 设置缓存服务域名
set cache_domain=sangcache.com
set cache_domain_ip=localhost
set cache_domain_config=%cache_domain_ip% %cache_domain%
rem 设置文件服务域名
set file_domain=www.sangfileapp.com
set file_domain_ip=localhost
set file_domain_config=%file_domain_ip% %file_domain%

rem 显示配置信息
echo     domainFile                 =   %domainFile%
echo     db_write_domain_config    =   %db_write_domain_config%
echo     db_read_domain_config     =   %db_read_domain_config%
echo     cache_domain_config        =   %cache_domain_config%
echo     file_domain_config   =   %file_domain_config%

rem 确定域名解析服务是否存在
if exist %domainFile% goto fileExit

:fileNotExit
echo 本地域名解析文件不存在
goto error

:fileExit

rem 查看域名解析服务器中是否有相应信息，如果没有则加入域名信息
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

rem 启动redis-server
cd %configPath%\redis*
rem 终止相关进程
taskkill /im redis* /f
redis-server.exe redis.conf
if ERRORLEVEL 9009 goto :error
echo redis缓存服务器启动成功

rem 启动MySQL服务
net start mysql

if ERRORLEVEL 128 goto success
if ERRORLEVEL 0 goto success

:error
echo 启动失败
goto end
:success
echo 启动成功
:end
pause
