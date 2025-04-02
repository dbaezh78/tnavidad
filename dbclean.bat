@echo off
setlocal enabledelayedexpansion

:inicio
cls
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo    PROCESAR CARPETA SEMANAL (s05, s06, etc.)
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo.
echo Carpetas disponibles en esta ruta:
dir /b /ad | find /v "src"
echo.
set /p "carpeta=Ingresa el nombre de la carpeta (ej: s06): "

:: Verificar si la carpeta existe
if not exist "%carpeta%\" (
    echo.
    echo ERROR: La carpeta "%carpeta%" no existe.
    pause
    goto inicio
)

:: Procesar cada día de la semana (sin preguntar)
for %%d in (
    "%carpeta%\domingo"
    "%carpeta%\lunes"
    "%carpeta%\martes"
    "%carpeta%\miercoles"
    "%carpeta%\jueves"
    "%carpeta%\viernes"
    "%carpeta%\sabado"
) do (
    if exist "%%d\" (
        echo Procesando: %%~nxd
        cd "%%d"
        
        :: Comandos a ejecutar (sin confirmación)
        del /q "*.htm" 2>nul
        move "src\*.mp3" . 2>nul
        del /q /s "src\*.txt" 2>nul
        rd /q /s "src" 2>nul
        
        cd ..\..\
    )
)

echo.
echo Proceso completado en "%carpeta%".
pause
goto inicio