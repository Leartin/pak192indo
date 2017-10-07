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

git pull

if not exist .\makeobj.exe (

    echo makeobj.exe doesn't exist
    echo PLEASE DOWNLOAD IT!
    ping 127.0.0.1 >>null
    exit

) else (
    rem delete old exported data
    rem  ------------------------
    del .\pak192.indo.rar
    del release\*.pak
    del release\config\*.tab
    del release\text\*.tab
    del release\text\*.txt
    del release\text\*.zip
    del release\doc\*.txt
    del release\sound\*.wav
    del release\sound\*.tab
    del release\log\*.* /Q
    rmdir /Q /S scenario\
    rmdir /Q /S text\
    rmdir /Q /S doc\
    rmdir /Q /S sound\
    if exist .\pak192.indo.rar (
        goto del
    ) else (

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
        if not exist release/log/building.log (
            :co_obj
            rem COMPILING 
            echo Compiling Objects
            makeobj DEBUG pak192 release/ master/Building/*.dat >>release/log/building.log
            goto compile
        ) else (
            if not exist release/log/goods.log (
                :co_mobj
                rem COMPILING OBJECT
                echo Compiling Misc Object
                makeobj DEBUG pak192 release/ master/goods/*.dat >>release/log/goods.log
                makeobj DEBUG pak192 release/ master/misc/misc.dat >>release/log/misc.log
                makeobj DEBUG pak128 release/ master/misc/logo.dat >>release/log/logo.log
                makeobj DEBUG pak192 release/ master/misc/halfheight/*.dat >>release/log/halfheight.log
                makeobj DEBUG pak192 release/ master/misc/outside.dat >>release/log/outside.log
                goto compile
            ) else (
                if not exist release/log/signals.log (
                    :co_sig
                    rem COMPILING SIGNALS
                    echo Compiling Signals
                    makeobj DEBUG pak192 release/ master/signal/*.dat >>release/log/signals.log
                    goto compile
                ) else (
                    if not exist release/log/way.log (
                        :co_way
                        rem COMPILING WAYS!!!!
                        echo Compiling Ways
                        makeobj DEBUG pak192 release/ master/way/*.dat >>release/log/way.log
                        makeobj DEBUG pak192 release/ master/way/road/*.dat >>release/log/way.log
                        makeobj DEBUG pak192 release/ master/way/track/*.dat >>release/log/way.log
                        makeobj DEBUG pak192 release/ master/way/bridges/*.dat >>release/log/way.log
                        goto compile
                    ) else (
                        if not exist release/log/symbol.log (
                            :co_sym
                            rem COMPILING SYMBOL
                            echo Compling Symbol
                            makeobj DEBUG pak192 release/ master/symbol/*.dat >>release/log/symbol.log
                            goto compile
                        ) else (
                            if not exist release/log/vehicle.log (
                                :co_va
                                rem COMPILING VEHICLE
                                echo Compiling Vehicle
                                makeobj DEBUG pak192 release/ master/vehicle/*.dat >>release/log/vehicle.log
                                goto compile
                            )
                        )
                            
                    )
                    
                )
                
            )
        )

        :copy
        rar.exe a master\scenario\scenario.rar master\scenario\*
        copy /b master\maintained_object\*.* release\
        copy /b master\scenario\scenario.rar release\scenario
        copy /b master\doc\*.* release\doc
        copy /b master\text\*.* release\text
        copy /b master\config\*.* release\config
        goto zip

        :zip
        if not exist pak192.indo.rar (
            rar.exe a pak192.indo.rar release\config\*
            rar.exe a pak192.indo.rar release\sound\*
            rar.exe a pak192.indo.rar release\scenario\*
            rar.exe a pak192.indo.rar release\text\*
            rar.exe a pak192.indo.rar release\doc\*
            rar.exe a pak192.indo.rar release\*
            goto copy
        ) else (
            dir /d /s
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
            exit
        )

        
    )

    
)
