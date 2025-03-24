@echo off
goto :main

:not_found_output
echo Error - Didn't found directory "Output"
pause>nil
goto :EOF

:not_found_paks
echo Error - Didn't found directory "Paks" (Output\WindowsNoEditor\VotV\Content\Paks)
pause>nil
goto :EOF

:go_upper
@REM Just go to a level higher (like to directory "project" from directory "project\utils")
set old_dir_current_directory=%CD%
set dir_current_directory=%~dp0

cd /d %dir_current_directory%
cd ..
set dir_current_directory=%CD%
goto :EOF

:main
echo This script will make a .zip file from .pak file for some mod managers like "Thunderstore mod manager", "r2modman", "Gale"...
echo But .pak file needs to be in an output directory "Output\WindowsNoEditor\VotV\Content\Paks"
echo Also required 7-Zip or WinRAR to be installed at path "C:\Program Files\7-Zip\" or "C:\Program Files\WinRAR\winrar" 
pause>nil

if NOT EXIST VotV call :go_upper

if NOT EXIST Output goto :not_found_output
if NOT EXIST Output\WindowsNoEditor\VotV\Content\Paks goto :not_found_paks


@REM just for name like %Y%M%D%h%m%sAlekzum-IWantToUseToiletAgain.zip
set cur_date=%date%
set cur_date=%cur_date:.=%
set cur_yea=%cur_date:~4,4%
set cur_mon=%cur_date:~2,2%
set cur_day=%cur_date:~0,2%
set cur_date=%cur_yea%%cur_mon%%cur_day%
set cur_time=%time%
set cur_time=%cur_time::=%
set cur_time=%cur_time:~0,-3%

@REM echo dir_current_directory=%dir_current_directory%

set archive_name=Alekzum-IWantToUseToiletAgain
@REM if NOT EXIST archive_packs mkdir archive_packs
@REM if EXIST %dir_current_directory%\%archive_name%.zip move "%dir_current_directory%\%archive_name%.zip" "%dir_current_directory%\archive_packs\%cur_date%%cur_time%%archive_name%.zip"


if NOT EXIST pak mkdir pak
echo copying .pak file to folder "pak"...
copy %dir_current_directory%\Output\WindowsNoEditor\VotV\Content\Paks\pakchunk13-WindowsNoEditor.pak %dir_current_directory%\pak\IWantToUseToiletAgain.pak > nil

echo archiving files for mod managers via 7-Zip...
"C:\Program Files\7-Zip\7z.exe" -tzip -mx1 a %archive_name% %dir_current_directory%\icon.png %dir_current_directory%\manifest.json %dir_current_directory%\README.md %dir_current_directory%\CHANGELOG.md %dir_current_directory%\pak -- >nil
del /q /s pak>nil

move %archive_name%.zip %dir_current_directory%>nil
cd /d %old_dir_current_directory%>nil