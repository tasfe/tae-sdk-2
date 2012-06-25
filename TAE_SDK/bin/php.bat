@rem ----- ExeScript Options Begin -----
@rem ScriptType: console,invoker
@rem DestDirectory: current
@rem Icon: default
@rem OutputFile: D:\DC_SDK\bin\php.exe
@rem Comments: DCSDK PHPΩ‚Œˆ∆˜
@rem CompanyName: Ã‘±¶
@rem FileVersion: 1.0.0.1
@rem LegalCopyright: Ã‘±¶
@rem ProductVersion: 1.0.0.1
@rem ----- ExeScript Options End -----

@echo off

setlocal

set DCSDK_HOME=%~dp0..

for %%x in ("%DCSDK_HOME%") do set DCSDK_HOME=%%~sx

:start
set TEMP_JAVA_HOME=%DCSDK_HOME%\jre

if exist "%TEMP_JAVA_HOME%\bin\java.exe" set JAVA_HOME=%TEMP_JAVA_HOME%
if exist "%JAVA_HOME%\bin\java.exe" goto JavaFound
echo JAVA_HOME does not point at a JDK or JRE.  Either set the JAVA_HOME environment variable or specify a JDK.
goto end

:JavaFound
set LIBRARY_PATH=%DCSDK_HOME%\lib\share
set JAVA_OPTS=-DDCSDK_HOME=%DCSDK_HOME% -Dfile.encoding=GBK

set START_JAR=.
for %%a in (%LIBRARY_PATH%\*.jar) do call set START_JAR=%%START_JAR%%;%%a
if not "%START_JAR%"=="" goto StartJarFound
echo start.jar was not found.  Check your SDK installation.
goto end

:StartJarFound
set JAVA_OPTS=-classpath "%START_JAR%" %JAVA_OPTS%

set PWD=%CD%

"%JAVA_HOME%\bin\java.exe" %JAVA_OPTS% com.taobao.dc.sdk.PhpCli %1 %2 %3 %4 %5

goto end

:end
