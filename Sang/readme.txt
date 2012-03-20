开发要求：

Eclipse  

环境搭建步骤:

所有工具在工程的tool目录下都会有.

1.安装jdk <jdk-6u10-windows-i586-p.exe> 如果有则跳过

2.设置JAVA_HOME环境变量
	右键我的电脑-->高级-->环境变量
	-->新建(第一个按钮)
	-->变量名填写JAVA_HOME
	-->变量值填写jdk的安装目录如(C:\Program Files\Java\jdk1.6.0_12)
	
3.安装mysql数据库服务 <mysql-essential-5.1.37-win32.msi> 如果有则跳过

4.启动eclipse安装egit插件
	Help-->Install New Software-->Add->Archive-->
	选择 <org.eclipse.egit-updatesite-1.3.0.201202151440-r-site.zip>

5.配置Server便于启动和调试Sang工程
	File-->New-->Other-->Server-->Tomcat6.0 Server
	-->Name 填写Tomcat6.0
	-->Tomcat Install Workdirectory 浏览 <apache-tomcat-6.0.20>
	-->jre 选择底下这个而非自带

6.显示Servers视图
	Window-->Show View-->Other-->Server
	
7.启动Tomcat服务器
	在新出的Servers视图中右键Tomcat6.0 --> Add and Remove --> 
	将Sang从左边加到右边-->Finish
	
	右键Tomcat6.0 -->start

8.在Eclipse配置外部tool工具
	配置开启批处理
	Run-->External Tools-->External Tools Configuration
	-->Program-->New launch configure
	-->Name填写sang_startup
	-->Location填写${workspace_loc:/Sang/tool/startup.bat}
	-->Work Directory填写${workspace_loc:/Sang/tool}
	-->Apply--close
	
	配置关闭批处理
	Run-->External Tools-->External Tools Configuration
	-->Program-->New launch configure
	-->Name填写sang_shutdown
	-->Location填写${workspace_loc:/Sang/tool/shutdown.bat}
	-->Work Directory填写${workspace_loc:/Sang/tool}
	-->Apply--close

9.开启redis服务和MySQL服务
	Run-->External Tools-->startup.bat

10.关闭redis服务和MySQL服务
	Run-->External Tools-->shutdown.bat