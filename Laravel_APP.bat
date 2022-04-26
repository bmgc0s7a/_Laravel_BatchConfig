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
    echo ----------------------------------------
    echo       WELCOME YOUR APP: !file!
    echo ----------------------------------------

    ECHO.
    ECHO SELECT A OPTION BELLOW
    ECHO.
    ECHO 1 - Make All Controller-Model-Factory-View
    ECHO 2 - Make Controller only
    ECHO.

    set /P Option="Option: " 

    cd ./!file!

    cls
    echo ----------------------------------------
    echo       WELCOME YOUR APP: !file!
    echo ----------------------------------------
    echo.
    echo ----------------------------------------
    IF !option! == 1 (
        echo    Make All Controller-Model-Factory-View
        echo ----------------------------------------
        echo.
        set /P Name="Name: "
        echo.
        call php artisan make:model !Name! -a
    ) ELSE IF !option! == 2 (
        echo                 Make Controller
        echo ---------------------------------------------
        echo.
        set /P Name="Name: "
        echo.
        call php artisan make:controller !Name!
    )
    pause
)