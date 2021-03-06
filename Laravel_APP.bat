@echo off 

setlocal EnableDelayedExpansion

IF NOT EXIST "conf.txt" (
    echo ----------------------------------------
    echo        WELCOME TO LARAVEL 
    echo ----------------------------------------

    set /P project="Project Name: " 

    echo !project! > conf.txt

    attrib conf.txt +h

    cls

    echo ----------------------------------------
    echo       INSTALL LARAVEL DEPENDENCY 
    echo ----------------------------------------

    call composer global require laravel/installer

    cls

    echo ----------------------------------------
    echo      CREATE PROJECT !project! 
    echo ----------------------------------------

    call composer create-project --prefer-dist laravel/laravel:^7.0 ./!project!


    cls

    cd ./!project!

    echo ----------------------------------------
    echo          COMPOSER INSTALL 
    echo ----------------------------------------

    call Composer install


    cls

    echo ----------------------------------------
    echo            NPM INSTALL
    echo ----------------------------------------

    call npm install

    cls

    echo ----------------------------------------
    echo         AUTENTICATE INSTALL
    echo ----------------------------------------

    call composer require laravel/ui:^2.4
    call php artisan ui vue --auth

    cls

    echo ----------------------------------------
    echo     NPM UPDATE AND EXECUTE RUN DEV
    echo ----------------------------------------

    call npm install
    call npm run dev

    cls

    echo ---------------------------------------------
    echo  CONGRATULATIONS, PROJECT !project! CREATED!
    echo ---------------------------------------------

) ELSE ( 
    set /p file=<conf.txt
    call :menu
)

@REM* Titulo do programa

:title
    cls
    echo ----------------------------------------
    echo       WELCOME YOUR APP: !file!
    echo ----------------------------------------
    echo.
goto :EOF

@REM* Menu

:menu 
    call :title
    ECHO 1 - Make All Controller-Model-Factory-View
    ECHO 2 - Make Controller only
    ECHO 3 - Make Migration only
    ECHO 4 - Make Factory
    ECHO 5 - Clear Cache  
    ECHO 6 - Revert Artisan Action
    ECHO.
    set /P Option="Option: " 
    call :txt_option !option!
    echo.
    call :exec_option !option!
    pause
goto :EOF

:txt_option
    call :title
    IF %1 == 1 (
        echo - Make All Controller-Model-Factory-View
    ) ELSE IF %1 == 2 (
        echo - Make Controller
    ) ELSE IF %1 == 3 (
        echo - Make Migration
    ) ELSE IF %1 == 4 (
        echo - Make Factory
    ) ELSE IF %1 == 5 (
        echo - Clean Cache
    ELSE IF %1 == 10 (
        echo - Revert Artisan Action
    ) else (
        echo Option %1 not exists
        goto :menu
    )
goto :EOF

:exec_option
    cd ./!file!
    IF  %1 LSS 5 (
        set /P Name="Name: "
    )

    IF %1 == 1 (
        call php artisan make:model !Name! -a 
    ) ELSE IF %1 == 2 (
        call php artisan make:controller !Name! --resource
    ) ELSE IF %1 == 3 (
        call php artisan make:migration create_!Name!_table
    ) ELSE IF %1 == 4 (
        call php artisan make:factory !Name!Factory
    ) ELSE IF %1 == 5 (
        call php artisan optimize:clear
        call composer dump-autoload
    ) ELSE IF %1 == 10 (
        call 
    )


goto :menu