@echo off
rem pak192.indo batch compiler by vzrenggamani on 10/07/2016
rem last updated for simutrans 120.2 Nightly build
rem compiled with makeobj 60.0

echo Compile Pak192.indo
echo ==============
echo.
echo This batch compiles to folder release.
echo It requires the file makeobj DEBUG.exe to be in the same
echo folder as this compiler.
echo.
attrib +H makeobj.exe
attrib +H rar.exe
attrib +R +H master
attrib +R +H developerdoc
attrib +R +H release
if not exist .\makeobj.exe goto abort

rem delete old exported data
rem  ------------------------
del \release\export\192indo.zip
del release\*.pak
del release\config\*.tab
del release\text\*.tab
del release\text\*.txt
del release\text\*.zip
del release\doc\*.txt
del release\sound\*.wav
del release\sound\*.tab
rmdir /Q /S scenario\
rmdir /Q /S text\
rmdir /Q /S doc\
rmdir /Q /S sound\
ping 127.0.0.1 >>null
goto makedir

:makedir
cls.
cd release\
mkdir config\
mkdir text\
mkdir doc\
mkdir sound\
mkdir log\
cd ..
goto compile

:compile
cls.
rem COMPILING 
echo Compiling Objects
makeobj DEBUG pak192 release/ master/Building/*.dat >>release/log/building.log

rem COMPILING OBJECT
echo Compiling Misc Object
makeobj DEBUG pak192 release/ master/goods/*.dat >>release/log/goods.log
makeobj DEBUG pak192 release/ master/Misc/misc.dat >>release/log/misc.log
makeobj DEBUG pak128 release/ master/Misc/logo.dat >>release/log/logo.log
makeobj DEBUG pak192 release/ master/Misc/halfheight/*.dat >>release/log/halfheight.log

rem COMPILING SIGNALS
echo Compiling Signals
makeobj DEBUG pak192 release/ master/signal/*.dat >>release/log/signals.log

rem COMPILING SYMBOL
echo Compling Symbol
makeobj DEBUG pak192 release/ master/symbol/*.dat >>release/log/symbol.log

rem COMPILING VEHICLE
echo Compiling Vehicle
makeobj DEBUG pak192 release/ master/vehicle/*.dat >>release/log/vehicle.log

rem COMPILING WAYS!!!!
echo Compiling Ways
makeobj DEBUG pak192 release/ master/way/*.dat >>release/log/way.log
makeobj DEBUG pak192 release/ master/way/road/*.dat >>release/log/way.log
makeobj DEBUG pak192 release/ master/way/track/*.dat >>release/log/way.log
makeobj DEBUG pak192 release/ master/way/bridges/*.dat >>release/log/way.log
goto copy

:copy
rar a master\scenario\scenario.rar master\scenario\*
copy /b master\maintained_object\*.* release\
copy /b master\scenario\scenario.rar release\scenario
copy /b master\doc\*.* release\doc
copy /b master\text\*.* release\text
copy /b master\config\*.* release\config
goto finish

:zip
cls.
echo ZIPPING CONFIGURATION FILES!
start rar.exe a pak192.indo.rar release\config\*
ping 127.0.0.1 -n 10 >>null
echo ZIPPING CONFIGURATION SOUND FILES!
start rar.exe a pak192.indo.rar release\sound\*
ping 127.0.0.1 -n 10 >>null
echo ZIPPING CONFIGURATION SCENARIO FILES!
start rar.exe a pak192.indo.rar release\scenario\*
ping 127.0.0.1 -n 10 >>null
echo ZIPPING CONFIGURATION TEXT FILES!
start rar.exe a pak192.indo.rar release\text\*
ping 127.0.0.1 -n 10 >>null
echo ZIPPING CONFIGURATION DOC FILES!
start rar.exe a pak192.indo.rar release\doc\*
ping 127.0.0.1 -n 10 >>null
echo ZIPPING CONFIGURATION pak FILES!
start rar.exe a pak192.indo.rar release\*



:finish
attrib -H makeobj.exe
attrib -H rar.exe
attrib -H -R master
attrib -R -H developerdoc
attrib -R -H release
del null
cls.
echo ==============
echo Compile Pak192.indo COMPLETE
echo ==============
echo.

echo Compiling DONE!
echo Press Anykey to exit
pause
start .\release\
exit